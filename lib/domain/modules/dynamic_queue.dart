import 'dart:math';

import 'package:rxdart/rxdart.dart';

import '../../constants.dart';
import '../../system/models/queue_item_model.dart';
import '../../system/models/song_model.dart';
import '../../system/utils.dart';
import '../entities/playable.dart';
import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../repositories/music_data_repository.dart';
import 'managed_queue_info.dart';

const int INITIAL_QUEUE_LENGTH = 50;
const int QUEUE_AHEAD = 10;

class DynamicQueue implements ManagedQueueInfo {
  DynamicQueue(
    this._musicDataRepository,
  );

  final MusicDataRepository _musicDataRepository;

  List<Song> get queue => _queue.map((e) => e.song).toList();

  /// The queue generated so far from the _availableSongs.
  List<QueueItem> _queue = [];
  final BehaviorSubject<List<QueueItem>> _queueSubject = BehaviorSubject.seeded([]);

  /// The list of songs available for queue generation with some extra information.
  List<QueueItem> _availableSongs = [];
  final BehaviorSubject<List<QueueItem>> _availableSongsSubject = BehaviorSubject.seeded([]);

  Playable? _playable;
  ShuffleMode _shuffleMode = ShuffleMode.none;

  @override
  ValueStream<List<QueueItem>> get availableSongsStream => _availableSongsSubject.stream;

  @override
  ValueStream<List<QueueItem>> get queueItemsStream => _queueSubject.stream;

  void init(
    List<QueueItem> queue,
    List<QueueItem> availableSongs,
    Playable playable,
    ShuffleMode shuffleMode,
  ) {
    _shuffleMode = shuffleMode;
    _playable = playable;

    // no push on subject here to not trigger persistence
    _queue = queue.cast();
    _availableSongs = availableSongs;
  }

  Future<int> generateQueue(
    List<Song> songs,
    Playable playable,
    int startIndex,
    ShuffleMode shuffleMode,
  ) async {
    _shuffleMode = shuffleMode;
    _playable = playable;

    _availableSongs = List.generate(
      songs.length,
      (i) => QueueItemModel(songs[i] as SongModel, originalIndex: i),
    );
    _availableSongsSubject.add(_availableSongs);

    final initialQueueItem = _availableSongs[startIndex];

    // FIXME: broken when first song is filtered out
    // when starting a shuffle playback, there needs to be an option to select a new startindex
    // in this case the startindex was selected randomly
    // otherwise the startindex item should be included as it was selected manually
    final filteredAvailableSongs = _filterAvailableSongs(_availableSongs);
    final newStartIndex = filteredAvailableSongs.indexOf(initialQueueItem);

    switch (_shuffleMode) {
      case ShuffleMode.none:
        return _generateNormalQueue(filteredAvailableSongs, newStartIndex);
      case ShuffleMode.standard:
        return await _generateShuffleQueue(filteredAvailableSongs, newStartIndex);
      case ShuffleMode.plus:
        return await _generateShuffleQueue(filteredAvailableSongs, newStartIndex, weighted: true);
    }
  }

  void addToQueue(Song song) {
    final queueItem = QueueItemModel(
      song as SongModel,
      originalIndex: _availableSongs.length, // interference with predecessors/successors?
      source: QueueItemSource.added,
      isAvailable: false,
    );

    _availableSongs.add(queueItem);
    _availableSongsSubject.add(_availableSongs);
    _queue.add(queueItem);
    _queueSubject.add(_queue);
  }

  void insertIntoQueue(List<Song> songs, int index) {
    final queueItems = <QueueItem>[];
    int i = 0;
    for (final song in songs) {
      queueItems.add(QueueItemModel(
        song as SongModel,
        originalIndex: _availableSongs.length + i, // interference with predecessors/successors?
        source: QueueItemSource.added,
        isAvailable: false,
      ));
      i++;
    }

    _availableSongs.addAll(queueItems);
    _availableSongsSubject.add(_availableSongs);
    _queue.insertAll(index, queueItems);
    _queueSubject.add(_queue);
  }

  void moveQueueItem(int oldIndex, int newIndex) {
    _queue.insert(newIndex, _queue.removeAt(oldIndex));
    _queueSubject.add(_queue);
  }

  void removeQueueIndex(int index, bool permanent) {
    final queueItem = _queue[index];

    if (permanent) {
      // if a song is removed from the queue, it should not pop up again when reshuffling
      _availableSongs.remove(queueItem);

      // this needs to update originalIndex
      for (int i = 0; i < _availableSongs.length; i++) {
        if (_availableSongs[i].originalIndex > queueItem.originalIndex) {
          _availableSongs[i].originalIndex -= 1;
        }
      }

      _availableSongsSubject.add(_availableSongs);
    }

    _queue.removeAt(index);
    _queueSubject.add(_queue);
  }

  Future<int> reshuffleQueue(ShuffleMode shuffleMode, int currentIndex) async {
    _shuffleMode = shuffleMode;
    final currentQueueItem = _queue[currentIndex];

    // make songs available again for new shuffle
    for (final qi in _availableSongs) {
      qi.isAvailable = true;
    }
    final filteredAvailableSongs = _filterAvailableSongs(_availableSongs);
    // TODO: what if the item is not in the filtered list?
    final newStartIndex = filteredAvailableSongs.indexOf(currentQueueItem);

    switch (_shuffleMode) {
      case ShuffleMode.none:
        return _generateNormalQueue(filteredAvailableSongs, newStartIndex);
      case ShuffleMode.standard:
        return await _generateShuffleQueue(filteredAvailableSongs, newStartIndex);
      case ShuffleMode.plus:
        return await _generateShuffleQueue(filteredAvailableSongs, newStartIndex, weighted: true);
    }
  }

  Future<List<Song>> updateCurrentIndex(int currentIndex) async {
    final int songsAhead = _queue.length - currentIndex - 1;
    int songsToQueue = QUEUE_AHEAD - songsAhead;

    if (songsToQueue > 0) {
      final filteredAvailableSongs = _filterAvailableSongs(_availableSongs);
      songsToQueue = min(songsToQueue, filteredAvailableSongs.length);
      if (filteredAvailableSongs.isNotEmpty) {
        List<QueueItem> newSongs = [];
        switch (_shuffleMode) {
          case ShuffleMode.none:
            newSongs = filteredAvailableSongs.sublist(0, songsToQueue);
            break;
          case ShuffleMode.standard:
            newSongs = await _shuffleQueue(filteredAvailableSongs, songsToQueue);
            break;
          case ShuffleMode.plus:
            newSongs = await _shufflePlusQueue(filteredAvailableSongs, songsToQueue);
        }

        newSongs.forEach((qi) {
          qi.isAvailable = false;
        });
        _queue.addAll(newSongs);
        _queueSubject.add(_queue);
        return newSongs.map((e) => e.song).toList();
      }
    }
    return [];
  }

  /// Update songs contained in queue. Return true if any song was changed.
  bool updateSongs(Map<String, Song> songs) {
    bool changed = false;

    for (int i = 0; i < _availableSongs.length; i++) {
      if (songs.containsKey(_availableSongs[i].song.path)) {
        final oldQueueItem = _availableSongs[i] as QueueItemModel;
        final newQueueItem = (_availableSongs[i] as QueueItemModel).copyWith(
          song: songs[_availableSongs[i].song.path]! as SongModel,
        );
        _availableSongs[i] = newQueueItem;

        final index = _queue.indexOf(oldQueueItem);
        if (index > -1) {
          _queue[index] = newQueueItem;
          changed = true;
        }
      }
    }

    // TODO: update streams here? -> don't think so because only properties of songs change

    return changed;
  }

  Future<List<QueueItem>> getQueueItemWithLinks(QueueItem queueItem) async {
    final List<QueueItem> queueItems = [];

    final predecessors = await _musicDataRepository.getPredecessors(queueItem.song);
    final successors = await _musicDataRepository.getSuccessors(queueItem.song);

    for (final p in predecessors) {
      queueItems.add(QueueItemModel(
        p as SongModel,
        originalIndex: queueItem.originalIndex,
        source: QueueItemSource.predecessor,
      ));
    }

    queueItems.add(queueItem);

    for (final s in successors) {
      queueItems.add(QueueItemModel(
        s as SongModel,
        originalIndex: queueItem.originalIndex,
        source: QueueItemSource.successor,
      ));
    }

    return queueItems;
  }

  List<QueueItem> _filterAvailableSongs(List<QueueItem> availableSongs) {
    final List<QueueItem> result = [];

    final blockLevel = calcBlockLevel(_shuffleMode, _playable!.type);

    for (int i = 0; i < availableSongs.length; i++) {
      final qi = availableSongs[i];
      if (!(qi.song.blockLevel > blockLevel) && qi.isAvailable) {
        result.add(qi);
      }
    }

    return result;
  }

  Future<int> _generateNormalQueue(List<QueueItem> queueItems, int startIndex) async {
    final queueLength = min(max(startIndex + QUEUE_AHEAD, INITIAL_QUEUE_LENGTH), queueItems.length);

    for (int i = 0; i < queueLength; i++) queueItems[i].isAvailable = false;

    _queue = queueItems.sublist(0, queueLength).cast();
    _queueSubject.add(_queue);
    return startIndex;
  }

  Future<int> _generateShuffleQueue(
    List<QueueItem> queueItems,
    int startIndex, {
    bool weighted = false,
  }) async {
    // keeping this list makes iterating the available songs easier
    final locallyAvailableSongs = List<QueueItem>.from(queueItems);

    final List<QueueItem> queue = [];
    final linkedItems = await getQueueItemWithLinks(queueItems[startIndex]);
    // TODO: need to add those to the _availableSongs?
    queue.addAll(linkedItems);
    // don't want to select these songs twice
    queue.forEach(locallyAvailableSongs.remove);

    final songsToQueue = INITIAL_QUEUE_LENGTH - queue.length;

    if (weighted) {
      queue.addAll(await _shufflePlusQueue(locallyAvailableSongs, songsToQueue));
    } else {
      queue.addAll(await _shuffleQueue(locallyAvailableSongs, songsToQueue));
    }

    // these qi are the same objects as in _availableSongs -> marks them to not be queued (again)
    queue.forEach((qi) {
      qi.isAvailable = false;
    });
    _queue = queue.cast();
    _queueSubject.add(_queue);
    return 0;
  }

  Future<List<QueueItem>> _shuffleQueue(List<QueueItem> queueItems, int length) async {
    final Random rnd = Random();
    final locallyAvailableSongs = List<QueueItem>.from(queueItems);
    final queue = <QueueItem>[];

    while (queue.length < length && locallyAvailableSongs.isNotEmpty) {
      final index = rnd.nextInt(locallyAvailableSongs.length);

      final linkedSong = await getQueueItemWithLinks(locallyAvailableSongs[index]);
      queue.addAll(linkedSong);
      if (linkedSong.length > 1) {
        linkedSong.forEach((q) => locallyAvailableSongs.removeWhere((e) => e.song == q.song));
      } else {
        locallyAvailableSongs.removeAt(index);
      }
    }

    return queue;
  }

  Future<List<QueueItem>> _shufflePlusQueue(List<QueueItem> queueItems, int length) async {
    final Random rnd = Random();
    final List<QueueItem> queue = [];
    final List<List<QueueItem>> buckets = List.generate(MAX_LIKE_COUNT + 1, (index) => []);

    for (final qi in queueItems) {
      buckets[qi.song.likeCount].add(qi);
    }

    while (queue.length < length && buckets.expand((e) => e).isNotEmpty) {
      final bucketIndex = _getBucketIndex(buckets);
      final bucket = buckets[bucketIndex];

      final index = rnd.nextInt(bucket.length);

      final linkedSong = await getQueueItemWithLinks(bucket[index]);
      queue.addAll(linkedSong);
      if (linkedSong.length > 1) {
        for (final q in linkedSong) {
          buckets[q.song.likeCount].removeWhere((e) => e.song == q.song);
        }
      } else {
        bucket.removeAt(index);
      }
    }

    return queue;
  }

  int _getBucketIndex(List<List> buckets) {
    final Random _rnd = Random();
    final List<int> tickets = [];

    tickets.add(buckets[0].length);
    tickets.add(buckets[1].length * 2);
    tickets.add(buckets[2].length * 4);
    tickets.add(buckets[3].length * 8);

    final int sum = tickets.fold(0, (prev, amount) => prev + amount);

    int rndNumber = _rnd.nextInt(sum);
    for (int i = 0; i < tickets.length; i++) {
      if (rndNumber < tickets[i]) {
        return i;
      } else {
        rndNumber -= tickets[i];
      }
    }
    throw Error();
  }
}
