import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:rxdart/rxdart.dart';

import '../../system/models/queue_item_model.dart';
import '../../system/models/song_model.dart';
import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

abstract class ManagedQueueInfo {
  ValueStream<List<QueueItem>/*!*/> get queueItemsStream;
  ValueStream<List<Song>> get originalSongsStream;
  ValueStream<List<Song>> get addedSongsStream;
}

class ManagedQueue implements ManagedQueueInfo {
  ManagedQueue(this._musicDataRepository) : _queue = [];

  static final _log = FimberLog('ManagedQueue');

  @override
  ValueStream<List<Song>> get addedSongsStream => _addedSongsSubject.stream;

  @override
  ValueStream<List<Song>> get originalSongsStream => _originalSongsSubject.stream;

  @override
  ValueStream<List<QueueItem>> get queueItemsStream => _queueItemsSubject.stream;

  final BehaviorSubject<List<QueueItem>> _queueItemsSubject = BehaviorSubject();
  final BehaviorSubject<List<Song>> _originalSongsSubject = BehaviorSubject();
  final BehaviorSubject<List<Song>> _addedSongsSubject = BehaviorSubject();

  List<Song> get queue => _queue.map((e) => e.song).toList();
  List<QueueItem> get queueItemList => _queue;

  final MusicDataInfoRepository _musicDataRepository;

  // this resembles the queue in AudioPlayer
  // QueueItems are needed to determine the original position of the current song
  List<QueueItem> _queue;
  List<Song> _originalSongs = [];
  List<Song> _addedSongs = [];

  void addToQueue(Song song) {
    _addedSongs.add(song);
    _addedSongsSubject.add(_addedSongs);
    final queueItem = QueueItemModel(
      song as SongModel,
      originalIndex: _addedSongs.length - 1,
      type: QueueItemType.added,
    );
    _queue.add(queueItem);
    _queueItemsSubject.add(_queue);
  }

  void initQueue(List<QueueItem> queueItems, List<Song> originalSongs, List<Song> addedSongs) {
    // no push on subject here to not trigger persistence?
    _queue = queueItems;
    _originalSongs = originalSongs;
    _addedSongs = addedSongs;
  }

  void insertIntoQueue(Song song, int index) {
    _addedSongs.add(song);
    _addedSongsSubject.add(_addedSongs);
    final queueItem = QueueItemModel(
      song as SongModel,
      originalIndex: _addedSongs.length - 1,
      type: QueueItemType.added,
    );
    _queue.insert(index, queueItem);
    _queueItemsSubject.add(_queue);
  }

  void moveQueueItem(int oldIndex, int newIndex) {
    final queueItem = _queue.removeAt(oldIndex);
    _queue.insert(newIndex, queueItem);
    _queueItemsSubject.add(_queue);
  }

  void removeQueueIndex(int index) {
    final queueItem = _queue[index];

    // if a song is removed from the queue, it should not pop up again when reshuffling
    if (queueItem.type == QueueItemType.added) {
      _addedSongs.removeAt(queueItem.originalIndex);
      _addedSongsSubject.add(_addedSongs);
    } else if (queueItem.type == QueueItemType.standard) {
      _originalSongs.removeAt(queueItem.originalIndex);
      _originalSongsSubject.add(_originalSongs);
    }

    for (int i = 0; i < queueItemList.length; i++) {
      if (queueItemList[i].type == queueItem.type &&
          queueItemList[i].originalIndex > queueItem.originalIndex) {
        queueItemList[i] = QueueItemModel(
          queueItemList[i].song as SongModel,
          originalIndex: queueItemList[i].originalIndex - 1,
          type: queueItemList[i].type,
        );
      }
    }

    _queue.removeAt(index);
    _queueItemsSubject.add(_queue);
  }

  // so this is the motivation behind all the original/added songs and queueitems:
  // to regenerate the original queue, we need the the original song list
  // and the position of the current song in this original song list
  Future<int> reshuffleQueue(
    ShuffleMode shuffleMode,
    int currentIndex,
  ) async {
    final songs = _originalSongs.cast<Song>() + _addedSongs;
    final currentQueueItem = _queue[currentIndex];
    int originalIndex = currentQueueItem.originalIndex;
    if (currentQueueItem.type == QueueItemType.added) {
      originalIndex += _originalSongs.length;
    }

    return await _generateQueue(shuffleMode, songs, originalIndex);
  }

  /// Generate a queue from [songs] according to [shuffleMode].
  Future<int> generateQueue(
    ShuffleMode shuffleMode,
    List<Song> songs,
    int startIndex,
  ) async {
    _originalSongs = songs;
    _originalSongsSubject.add(_originalSongs);
    _addedSongs = [];
    _addedSongsSubject.add(_addedSongs);

    return await _generateQueue(shuffleMode, songs, startIndex);
  }

  // ignore: missing_return
  Future<int> _generateQueue(
    ShuffleMode shuffleMode,
    List<Song> songs,
    int startIndex,
  ) async {
    switch (shuffleMode) {
      case ShuffleMode.none:
        return _generateNormalQueue(songs, startIndex);
      case ShuffleMode.standard:
        return _generateShuffleQueue(songs, startIndex);
      case ShuffleMode.plus:
        return await _generateShufflePlusQueue(songs, startIndex);
    }
  }

  int _generateNormalQueue(List<Song> songs, int startIndex) {
    _queue = List<QueueItem>.generate(
      songs.length,
      (i) => QueueItemModel(
        songs[i] as SongModel,
        originalIndex: i,
      ),
    );
    _queueItemsSubject.add(_queue);
    return startIndex;
  }

  int _generateShuffleQueue(List<Song> songs, int startIndex) {
    final List<QueueItem> queue = List<QueueItem>.generate(
      songs.length,
      (i) => QueueItemModel(
        songs[i] as SongModel,
        originalIndex: i,
      ),
    );
    queue.removeAt(startIndex);
    queue.shuffle();
    final first = QueueItemModel(
      songs[startIndex] as SongModel,
      originalIndex: startIndex,
    );
    _queue = [first] + queue.cast();
    _queueItemsSubject.add(_queue);
    return 0;
  }

  Future<int> _generateShufflePlusQueue(List<Song> songs, int startIndex) async {
    final List<QueueItem> queue = await _getQueueItemWithLinks(
      songs[startIndex],
      startIndex,
    );
    // determine the start index in cases where the "first song" has predecessors
    int newStartIndex = 0;
    for (final qi in queue) {
      if (qi.song.path == songs[startIndex].path) {
        break;
      } else {
        newStartIndex++;
      }
    }

    final List<int> indices = [];
    final List<int> filteredIndices = [];

    // filter mediaitem list
    for (var i = 0; i < songs.length; i++) {
      if (i != startIndex && !songs[i].blocked) {
        indices.addAll(List.generate(songs[i].likeCount + 1, (_) => i));
      } else if (i != startIndex) {
        filteredIndices.add(i);
      }
    }

    indices.shuffle();

    for (final index in indices) {
      final Song song = songs[index];

      queue.addAll(await _getQueueItemWithLinks(song, index));
    }

    _queue = queue;
    _queueItemsSubject.add(_queue);

    return newStartIndex;
  }

  // TODO: naming things is hard
  Future<List<QueueItem>> _getQueueItemWithLinks(
    Song song,
    int index,
  ) async {
    final List<QueueItem> queueItems = [];

    final predecessors = await _getPredecessors(song);
    final successors = await _getSuccessors(song);

    for (final p in predecessors) {
      queueItems.add(QueueItemModel(
        p as SongModel,
        originalIndex: index,
        type: QueueItemType.predecessor,
      ));
    }

    queueItems.add(QueueItemModel(
      song as SongModel,
      originalIndex: index,
    ));

    for (final s in successors) {
      queueItems.add(QueueItemModel(
        s as SongModel,
        originalIndex: index,
        type: QueueItemType.successor,
      ));
    }

    return queueItems;
  }

  Future<List<Song>> _getPredecessors(Song song) async {
    final List<Song> songs = [];
    Song currentSong = song;

    while (currentSong.previous != '') {
      currentSong = await _musicDataRepository.getSongByPath(currentSong.previous);
      songs.add(currentSong);
    }

    return songs.reversed.toList();
  }

  Future<List<Song>> _getSuccessors(Song song) async {
    final List<Song> songs = [];
    Song currentSong = song;

    while (currentSong.next != '') {
      currentSong = await _musicDataRepository.getSongByPath(currentSong.next);
      songs.add(currentSong);
    }

    return songs.toList();
  }
}
