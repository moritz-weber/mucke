import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:rxdart/rxdart.dart';

import '../../constants.dart';
import '../../system/models/queue_item_model.dart';
import '../../system/models/song_model.dart';
import '../entities/playable.dart';
import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../repositories/music_data_repository.dart';
import '../utils.dart';
import 'managed_queue_info.dart';

const int INITIAL_QUEUE_LENGTH = 50;
const int QUEUE_AHEAD = 10;

class DynamicQueue implements ManagedQueueInfo {
  DynamicQueue(
    this._musicDataRepository,
  );

  static final _log = FimberLog('DynamicQueue');

  final MusicDataRepository _musicDataRepository;

  /// The queue as a list of Songs instead of QueueItems.
  List<Song> get queue => _queue.map((e) => e.song).toList();

  /// The list of Songs still available for queue generation, excluding songs that have already been queued.
  List<Song> get availableSongs =>
      _availableSongs.where((element) => element.isAvailable).map((e) => e.song).toList();

  @override
  ValueStream<List<QueueItem>> get availableSongsStream => _availableSongsSubject.stream;

  @override
  ValueStream<List<QueueItem>> get queueItemsStream => _queueSubject.stream;

  @override
  ValueStream<Playable> get playableStream => _playableSubject.stream;

  /// The queue generated so far from the [_availableSongs].
  List<QueueItem> _queue = [];

  /// This is used to communicate changes to [_queue] to the rest of the system.
  final BehaviorSubject<List<QueueItem>> _queueSubject = BehaviorSubject.seeded([]);

  /// The list of songs available for queue generation with some extra information.
  List<QueueItem> _availableSongs = [];

  /// This is used to communicate changes to [_availableSongs] to the rest of the system.
  final BehaviorSubject<List<QueueItem>> _availableSongsSubject = BehaviorSubject.seeded([]);

  /// This holds the current Playable as value and communicates it with the rest of the system.
  final BehaviorSubject<Playable> _playableSubject = BehaviorSubject();

  /// Initializes the DynamicQueue with a [queue], [availableSongs] and [playable] from a previous run of the app.
  void init(
    List<QueueItem> queue,
    List<QueueItem> availableSongs,
    Playable playable,
  ) {
    // for every item in queue, take the corresponding object from availableSongs
    // discard elements from queue that are not in availableSongs (this should not happen)
    final List<QueueItem> tmpQueue = [];
    for (final qi in queue) {
      final avSong = availableSongs.firstWhereOrNull((e) => e == qi);
      if (avSong != null)
        tmpQueue.add(avSong);
      else
        _log.w('Item not found in availableSongs: $qi');
    }
    _availableSongs = availableSongs;
    _queue = tmpQueue;

    _playableSubject.add(playable);
    _availableSongsSubject.add(availableSongs);
    _queueSubject.add(_queue);
  }

  /// Generates a queue from the given [songs], depending the containing [playable] and [shuffleMode].
  ///
  /// Returns the index of the starting song.
  /// [startIndex] determines the song that is set to be played first.
  /// If [keepIndex] is true, the starting song will stay in the resulting queue, even if it would normally get filtered out.
  Future<int> generateQueue(
    List<Song> songs,
    Playable playable,
    int startIndex,
    ShuffleMode shuffleMode, {
    bool keepIndex = false,
  }) async {
    // create corresponing QueueItems for the given songs
    _availableSongs = List.generate(
      songs.length,
      (i) => QueueItemModel(songs[i] as SongModel, originalIndex: i),
    );
    final initialQueueItem = _availableSongs[startIndex];

    // filter the created QueueItems based on the calculated block level
    List<QueueItem> filteredAvailableSongs = filterAvailableSongs(
      _availableSongs,
      indices: [startIndex],
      keepIndex: keepIndex,
      blockLevel: calcBlockLevel(shuffleMode, playable),
    );
    // if all songs would be filtered out, we just don't apply the filter
    if (filteredAvailableSongs.isEmpty) filteredAvailableSongs = _availableSongs;

    // determine the corresponding starting index in the filtered songs
    int newStartIndex = filteredAvailableSongs.indexOf(initialQueueItem);
    // if the starting song is filtered out, select another one
    if (newStartIndex < 0) {
      if (shuffleMode == ShuffleMode.none) {
        newStartIndex = determineNewStartIndex(startIndex, _availableSongs, filteredAvailableSongs);
      } else {
        newStartIndex = Random().nextInt(filteredAvailableSongs.length);
      }
    }

    int returnIndex = -1;
    switch (shuffleMode) {
      case ShuffleMode.none:
        returnIndex = await _generateNormalQueue(filteredAvailableSongs, newStartIndex);
        break;
      case ShuffleMode.standard:
        returnIndex = await _generateShuffleQueue(filteredAvailableSongs, newStartIndex);
        break;
      case ShuffleMode.plus:
        returnIndex =
            await _generateShuffleQueue(filteredAvailableSongs, newStartIndex, weighted: true);
    }

    _playableSubject.add(playable);
    // it's important to do this here because the entries in _availableSongs are changed by
    // the queue generation methods
    _availableSongsSubject.add(_availableSongs);
    return returnIndex;
  }

  /// Adds a list of [songs] to the queue and to the list of available songs.
  void addToQueue(List<Song> songs) {
    final queueItems = <QueueItem>[];
    int i = 0;
    for (final song in songs) {
      queueItems.add(
        QueueItemModel(
          song as SongModel,
          originalIndex: _availableSongs.length + i, // interference with predecessors/successors?
          source: QueueItemSource.added,
          isAvailable: false,
        ),
      );
      i++;
    }
    _availableSongs.addAll(queueItems);
    _availableSongsSubject.add(_availableSongs);
    _queue.addAll(queueItems);
    _queueSubject.add(_queue);
  }

  void insertIntoQueue(List<Song> songs, int index) {
    _log.d('insertIntoQueue');
    final queueItems = <QueueItemModel>[];
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
    _queue.insertAll(min(_queue.length, index), queueItems);
    _queueSubject.add(_queue);
  }

  /// Move the QueueItem at index [oldIndex] to [newIndex].
  void moveQueueItem(int oldIndex, int newIndex) {
    _queue.insert(newIndex, _queue.removeAt(oldIndex));
    _queueSubject.add(_queue);
  }

  void removeQueueIndices(List<int> indices, bool permanent) {
    _log.d('removeQueueIndices');

    for (final index in indices..sort((a, b) => -a.compareTo(b))) {
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
      }
      _queue.removeAt(index);
    }

    if (permanent) _availableSongsSubject.add(_availableSongs);
    _queueSubject.add(_queue);
  }

  Future<int> reshuffleQueue(ShuffleMode shuffleMode, int currentIndex) async {
    _log.d('reshuffleQueue');
    QueueItem currentQueueItem = _queue[currentIndex];

    const validSources = [QueueItemSource.original, QueueItemSource.added];
    _availableSongs.removeWhere((element) => !validSources.contains(element.source));

    // make songs available again for new shuffle
    for (final qi in _availableSongs) {
      qi.isAvailable = true;
    }

    int index = _availableSongs.indexOf(currentQueueItem);
    int anchorIndex = -1;
    QueueItem? anchorItem;
    // linked songs are not in _availableSongs
    if (index < 0) {
      // see if at least the right song is in _availableSongs
      index = _availableSongs.indexWhere((element) => element.song == currentQueueItem.song);
      if (index >= 0) {
        currentQueueItem = _availableSongs[index];
      } else {
        // song is not available -> add the current item to available songs
        // if the linked song is available, place the currentQueueItem before or after
        anchorIndex = _availableSongs.indexWhere((element) =>
            element.originalIndex == currentQueueItem.originalIndex &&
            validSources.contains(element.source));
        if (anchorIndex >= 0) {
          anchorItem = _availableSongs[anchorIndex];
          if (currentQueueItem.source == QueueItemSource.predecessor) {
            _availableSongs.insert(anchorIndex, currentQueueItem);
            index = anchorIndex;
            anchorIndex += 1;
          } else {
            _availableSongs.insert(anchorIndex + 1, currentQueueItem);
            index = anchorIndex + 1;
          }
        } else {
          // linked song is not available -> just add to the end
          index = _availableSongs.length;
          _availableSongs.add(currentQueueItem);
        }
      }
    }

    final indicesToKeep = [index];
    if (anchorIndex >= 0) {
      indicesToKeep.add(anchorIndex);
    }

    final filteredAvailableSongs = filterAvailableSongs(
      _availableSongs,
      keepIndex: true,
      indices: indicesToKeep,
      blockLevel: calcBlockLevel(shuffleMode, _playableSubject.value),
    );
    int newStartIndex = -1;
    if (anchorIndex >= 0) {
      newStartIndex = filteredAvailableSongs.indexOf(anchorItem!);
    } else {
      newStartIndex = filteredAvailableSongs.indexOf(currentQueueItem);
    }

    switch (shuffleMode) {
      case ShuffleMode.none:
        await _generateNormalQueue(filteredAvailableSongs, newStartIndex);
        break;
      case ShuffleMode.standard:
        await _generateShuffleQueue(filteredAvailableSongs, newStartIndex);
        break;
      case ShuffleMode.plus:
        await _generateShuffleQueue(filteredAvailableSongs, newStartIndex, weighted: true);
    }

    return _queue.indexOf(currentQueueItem);
  }

  /// Reacts to updates of [currentIndex] and returns a list of newly queued songs.
  Future<List<Song>> onCurrentIndexUpdated(int currentIndex, ShuffleMode shuffleMode) async {
    _log.d('onCurrentIndexUpdated');
    final int numSongsAhead = _queue.length - currentIndex - 1;
    int numSongsToQueue = QUEUE_AHEAD - numSongsAhead;

    if (numSongsToQueue > 0) {
      final filteredAvailableSongs = filterAvailableSongs(
        _availableSongs,
        blockLevel: calcBlockLevel(shuffleMode, _playableSubject.value),
      );
      numSongsToQueue = min(numSongsToQueue, filteredAvailableSongs.length);
      if (filteredAvailableSongs.isNotEmpty) {
        List<QueueItem> newSongs = [];
        switch (shuffleMode) {
          case ShuffleMode.none:
            newSongs = filteredAvailableSongs.sublist(0, numSongsToQueue);
            break;
          case ShuffleMode.standard:
            newSongs = await _shuffleQueue(filteredAvailableSongs, numSongsToQueue);
            break;
          case ShuffleMode.plus:
            newSongs = await _shufflePlusQueue(filteredAvailableSongs, numSongsToQueue);
        }

        for (final qi in newSongs) {
          qi.isAvailable = false;
        }
        _queue.addAll(newSongs);
        _queueSubject.add(_queue);
        _availableSongsSubject.add(_availableSongs);
        return newSongs.map((e) => e.song).toList();
      }
    }
    return [];
  }

  /// Update songs contained in queue. Return true if any song was changed.
  bool onSongsUpdated(Map<String, Song> songs) {
    _log.d('updateSongs');
    bool queueChanged = false;
    bool availableSongsChanged = false;

    for (int i = 0; i < _availableSongs.length; i++) {
      if (songs.containsKey(_availableSongs[i].song.path)) {
        availableSongsChanged = true;

        final oldQueueItem = _availableSongs[i] as QueueItemModel;
        final newQueueItem = (_availableSongs[i] as QueueItemModel).copyWith(
          song: songs[_availableSongs[i].song.path]! as SongModel,
        );
        _availableSongs[i] = newQueueItem;

        final index = _queue.indexOf(oldQueueItem);
        if (index > -1) {
          _queue[index] = newQueueItem;
          queueChanged = true;
        }
      }
    }

    // WARNING: When the app was keeping a skip counter for every song,
    // this was called too often while quickly skipping through a queue.
    // In general, this is fine though.
    if (availableSongsChanged) _availableSongsSubject.add(_availableSongs);
    if (queueChanged) _queueSubject.add(_queue);

    return queueChanged;
  }

  bool removeSongs(Set<String> paths) {
    _log.d('removeSongs');
    bool queueChanged = false;
    bool availableSongsChanged = false;

    final List<int> removedOriginalIndices = [];

    for (int i = 0; i < _availableSongs.length; i++) {
      if (paths.contains(_availableSongs[i].song.path)) {
        availableSongsChanged = true;
        final queueItem = _availableSongs.removeAt(i);
        removedOriginalIndices.add(queueItem.originalIndex);

        final index = _queue.indexOf(queueItem);
        if (index > -1) {
          _queue.removeAt(index);
          queueChanged = true;
        }
      }
    }
    removedOriginalIndices.sort();
    // this needs to update originalIndex
    for (int i = 0; i < _availableSongs.length; i++) {
      final originalIndex = _availableSongs[i].originalIndex;
      for (int j = 0; j < removedOriginalIndices.length; j++) {
        if (originalIndex > removedOriginalIndices[j]) {
          _availableSongs[i].originalIndex -= 1;
        } else
          break;
      }
    }

    if (availableSongsChanged) _availableSongsSubject.add(_availableSongs);
    if (queueChanged) _queueSubject.add(_queue);

    return queueChanged;
  }

  int getNextNormalIndex(int index) {
    if (index >= _queue.length) return _queue.length;

    int i = index;
    while (i < _queue.length && _queue[i].source == QueueItemSource.added) {
      i++;
    }

    return i;
  }

  /// Determines a new starting song close to the original one.
  /// 
  /// [allAvailableSongs] contains the original starting song at [oldStartIndex].
  /// Searches through the neighborhood of the original starting song around [oldStartIndex]
  /// until it find a song that is also present in [filteredAvailableSongs].
  int determineNewStartIndex(
    int oldStartIndex,
    List<QueueItem> allAvailableSongs,
    List<QueueItem> filteredAvailableSongs,
  ) {
    int newStartIndex = -1;

    int i = 1;
    while (true) {
      if (oldStartIndex + i < allAvailableSongs.length) {
        newStartIndex = filteredAvailableSongs.indexOf(allAvailableSongs[oldStartIndex + i]);
        if (newStartIndex >= 0) break;
      }
      if (oldStartIndex - i >= 0) {
        newStartIndex = filteredAvailableSongs.indexOf(allAvailableSongs[oldStartIndex - i]);
        if (newStartIndex >= 0) break;
      }
      i++;
    }

    return newStartIndex;
  }

  Future<List<QueueItem>> _getQueueItemWithLinks(QueueItem queueItem, List<QueueItem> pool) async {
    final List<QueueItem> queueItems = [];

    final predecessors = await _musicDataRepository.getPredecessors(queueItem.song);
    final successors = await _musicDataRepository.getSuccessors(queueItem.song);

    for (final p in predecessors) {
      queueItems.add(pool.firstWhere(
        (element) => element.song == p,
        orElse: () => QueueItemModel(
          p as SongModel,
          originalIndex: queueItem.originalIndex,
          source: QueueItemSource.predecessor,
        ),
      ));
    }

    queueItems.add(queueItem);

    for (final s in successors) {
      queueItems.add(pool.firstWhere(
        (element) => element.song == s,
        orElse: () => QueueItemModel(
          s as SongModel,
          originalIndex: queueItem.originalIndex,
          source: QueueItemSource.successor,
        ),
      ));
    }

    return queueItems;
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
    final linkedItems = await _getQueueItemWithLinks(queueItems[startIndex], queueItems);
    queue.addAll(linkedItems);
    // don't want to select these songs twice
    linkedItems.forEach(locallyAvailableSongs.remove);

    final songsToQueue = INITIAL_QUEUE_LENGTH - queue.length;

    if (weighted) {
      queue.addAll(await _shufflePlusQueue(locallyAvailableSongs, songsToQueue));
    } else {
      queue.addAll(await _shuffleQueue(locallyAvailableSongs, songsToQueue));
    }

    // these qi are the same objects as in _availableSongs -> marks them to not be queued (again)
    for (final qi in queue) {
      qi.isAvailable = false;
    }
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

      final linkedSong = await _getQueueItemWithLinks(locallyAvailableSongs[index], queueItems);
      queue.addAll(linkedSong);
      if (linkedSong.length > 1) {
        for (final q in linkedSong) {
          locallyAvailableSongs.removeWhere((e) => e.song == q.song);
        }
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

      final linkedSong = await _getQueueItemWithLinks(bucket[index], queueItems);
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
