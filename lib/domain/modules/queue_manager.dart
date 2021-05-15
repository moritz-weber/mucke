import 'package:flutter_fimber/flutter_fimber.dart';

import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

class ManagedQueue {
  ManagedQueue(this._musicDataRepository);

  static final _log = FimberLog('ManagedQueue');

  List<Song> get queue => _queue.map((e) => e.song).toList();
  List<QueueItem> get queueItemList => _queue;

  final MusicDataInfoRepository _musicDataRepository;

  // die brauch ich aktuell für den originalIndex für neue Songs
  List<Song> _originalSongList = [];
  List<Song> _addedSongs = [];
  // this resembles the queue in AudioPlayer
  // QueueItems are needed to determine the original position of the current song
  List<QueueItem> _queue;
  List<QueueItem> _filteredQueueItems = [];

  void addToQueue(Song song) {
    _addedSongs.add(song);
    final queueItem = QueueItem(
      song,
      originalIndex: _addedSongs.length - 1,
      type: QueueItemType.added,
    );
    _queue.add(queueItem);
  }

  void insertIntoQueue(Song song, int index) {
    _addedSongs.add(song);
    final queueItem = QueueItem(
      song,
      originalIndex: _addedSongs.length - 1,
      type: QueueItemType.added,
    );
    _queue.insert(index, queueItem);
  }

  void moveQueueItem(int oldIndex, int newIndex) {
    final queueItem = _queue.removeAt(oldIndex);
    _queue.insert(newIndex, queueItem);
  }

  void removeQueueIndex(int index) {
    final queueItem = _queue[index];

    // if a song is removed from the queue, it should not pop up again when reshuffling
    if (queueItem.type == QueueItemType.added) {
      _addedSongs.removeAt(queueItem.originalIndex);
    } else if (queueItem.type == QueueItemType.standard) {
      _originalSongList.removeAt(queueItem.originalIndex);
    }

    for (int i = 0; i < queueItemList.length; i++) {
      if (queueItemList[i].type == queueItem.type && queueItemList[i].originalIndex > queueItem.originalIndex) {
        queueItemList[i] = QueueItem(
          queueItemList[i].song,
          originalIndex: queueItemList[i].originalIndex - 1,
          type: queueItemList[i].type,
        );
      }
    }

    _queue.removeAt(index);
  }

  // so this is the motivation behind all the original/added songs and queueitems:
  // to regenerate the original queue, we need the the original song list 
  // and the position of the current song in this original song list
  Future<int> reshuffleQueue(
    ShuffleMode shuffleMode,
    int currentIndex,
  ) async {
    final songs = _originalSongList.cast<Song>() + _addedSongs;
    final currentQueueItem = _queue[currentIndex];
    int originalIndex = currentQueueItem.originalIndex;
    if (currentQueueItem.type == QueueItemType.added) {
      originalIndex += _originalSongList.length;
    }

    return await _generateQueue(shuffleMode, songs, originalIndex);
  }

  /// Generate a queue from [songs] according to [shuffleMode].
  Future<int> generateQueue(
    ShuffleMode shuffleMode,
    List<Song> songs,
    int startIndex,
  ) async {
    _originalSongList = songs;
    _addedSongs = [];

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
      (i) => QueueItem(
        songs[i],
        originalIndex: i,
      ),
    );
    return startIndex;
  }

  int _generateShuffleQueue(
    List<Song> songs,
    int startIndex,
  ) {
    final List<QueueItem> queue = List<QueueItem>.generate(
      songs.length,
      (i) => QueueItem(
        songs[i],
        originalIndex: i,
      ),
    );
    queue.removeAt(startIndex);
    queue.shuffle();
    final first = QueueItem(
      songs[startIndex],
      originalIndex: startIndex,
    );
    _queue = [first] + queue;
    return 0;
  }

  Future<int> _generateShufflePlusQueue(
    List<Song> songs,
    int startIndex,
  ) async {
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

    final List<QueueItem> filteredQueue = [];
    for (final index in filteredIndices) {
      filteredQueue.add(QueueItem(songs[index], originalIndex: index));
    }

    _filteredQueueItems = filteredQueue;

    _queue = queue;

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
      queueItems.add(QueueItem(
        p,
        originalIndex: index,
        type: QueueItemType.predecessor,
      ));
    }

    queueItems.add(QueueItem(
      song,
      originalIndex: index,
    ));

    for (final p in successors) {
      queueItems.add(QueueItem(
        p,
        originalIndex: index,
        type: QueueItemType.successor,
      ));
    }

    return queueItems;
  }

  Future<List<Song>> _getPredecessors(Song song) async {
    final List<Song> songs = [];
    Song currentSong = song;

    while (currentSong.previous != null) {
      currentSong = await _musicDataRepository.getSongByPath(currentSong.previous);
      songs.add(currentSong);
    }

    return songs.reversed.toList();
  }

  Future<List<Song>> _getSuccessors(Song song) async {
    final List<Song> songs = [];
    Song currentSong = song;

    while (currentSong.next != null) {
      currentSong = await _musicDataRepository.getSongByPath(currentSong.next);
      songs.add(currentSong);
    }

    return songs.toList();
  }

  List<Song> _calculateOriginalSongList(List<QueueItem> queueItemList) {
    final Map<int, QueueItem> original = {};
    final Map<int, QueueItem> added = {};

    for (final qi in queueItemList) {
      if (qi.type == QueueItemType.standard) {
        original[qi.originalIndex] = qi;
      } else if (qi.type == QueueItemType.added) {
        added[qi.originalIndex] = qi;
      }
    }

    for (final qi in _filteredQueueItems) {
      if (qi.type == QueueItemType.standard) {
        original[qi.originalIndex] = qi;
      } else if (qi.type == QueueItemType.added) {
        original[qi.originalIndex] = qi;
      }
    }

    final List<QueueItem> originalList = original.values.toList();
    final List<QueueItem> addedList = added.values.toList();

    originalList.sort((a, b) => a.originalIndex.compareTo(b.originalIndex));
    addedList.sort((a, b) => a.originalIndex.compareTo(b.originalIndex));


    return originalList.map((e) => e.song).toList() + addedList.map((e) => e.song).toList();
  }
}
