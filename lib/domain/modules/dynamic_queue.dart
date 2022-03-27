import 'dart:math';

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

  List<Song> get queue => _queue.map((e) => e.song).toList();

  /// The queue generated so far from the _availableSongs.
  List<QueueItem> _queue = [];
  final BehaviorSubject<List<QueueItem>> _queueSubject = BehaviorSubject.seeded([]);

  /// The list of songs available for queue generation with some extra information.
  List<QueueItem> _availableSongs = [];
  final BehaviorSubject<List<QueueItem>> _availableSongsSubject = BehaviorSubject.seeded([]);

  final BehaviorSubject<Playable> _playableSubject = BehaviorSubject();
  ShuffleMode _shuffleMode = ShuffleMode.none;

  @override
  ValueStream<List<QueueItem>> get availableSongsStream => _availableSongsSubject.stream;

  @override
  ValueStream<List<QueueItem>> get queueItemsStream => _queueSubject.stream;

  @override
  ValueStream<Playable> get playableStream => _playableSubject.stream;

  void init(
    List<QueueItem> queue,
    List<QueueItem> availableSongs,
    Playable playable,
    ShuffleMode shuffleMode,
  ) {
    _log.d('init');
    _shuffleMode = shuffleMode;
    _playableSubject.add(playable);
    _log.d(availableSongs.length.toString());

    _availableSongs = availableSongs;
    _availableSongsSubject.add(_availableSongs);
    // for every item in queue, take the corresponding object from availableSongs
    _queue = queue
        .map((qi) => availableSongs.firstWhere(
              (e) => e == qi,
              orElse: () {
                _log.d(qi.toString());
                return qi as QueueItemModel;
              },
            ))
        .toList();
    _queueSubject.add(_queue);
  }

  Future<int> generateQueue(
    List<Song> songs,
    Playable playable,
    int startIndex,
    ShuffleMode shuffleMode, {
    bool keepIndex = false,
  }) async {
    _log.d('generateQueue');
    _shuffleMode = shuffleMode;
    _playableSubject.add(playable);

    _availableSongs = List.generate(
      songs.length,
      (i) => QueueItemModel(songs[i] as SongModel, originalIndex: i),
    );

    final initialQueueItem = _availableSongs[startIndex];

    List<QueueItem> filteredAvailableSongs = filterAvailableSongs(
      _availableSongs,
      indeces: [startIndex],
      keepIndex: keepIndex,
      blockLevel: calcBlockLevel(_shuffleMode, _playableSubject.value),
    );
    if (filteredAvailableSongs.isEmpty) filteredAvailableSongs = _availableSongs;

    int newStartIndex = filteredAvailableSongs.indexOf(initialQueueItem);

    // if the starting song is filtered out, select another one
    if (newStartIndex < 0) {
      if (shuffleMode == ShuffleMode.none) {
        // select new starting song near the original one
        int i = 1;
        while (true) {
          if (startIndex + i < _availableSongs.length) {
            newStartIndex = filteredAvailableSongs.indexOf(_availableSongs[startIndex + i]);
            if (newStartIndex >= 0) break;
          }
          if (startIndex - i >= 0) {
            newStartIndex = filteredAvailableSongs.indexOf(_availableSongs[startIndex - i]);
            if (newStartIndex >= 0) break;
          }
          i++;
        }
      } else {
        newStartIndex = Random().nextInt(filteredAvailableSongs.length);
      }
    }

    int returnIndex = -1;
    switch (_shuffleMode) {
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

    // it's important to do this here because the entries in _available songs are changed by
    // the queue generation methods
    _availableSongsSubject.add(_availableSongs);
    return returnIndex;
  }

  void addToQueue(List<Song> songs) {
    _log.d('addToQueue');
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
    _queue.addAll(queueItems);
    _queueSubject.add(_queue);
  }

  void insertIntoQueue(List<Song> songs, int index) {
    _log.d('insertIntoQueue');
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
    _log.d('moveQueueItem');
    _queue.insert(newIndex, _queue.removeAt(oldIndex));
    _queueSubject.add(_queue);
  }

  void removeQueueIndeces(List<int> indeces, bool permanent) {
    _log.d('removeQueueIndeces');

    for (final index in indeces..sort(((a, b) => -a.compareTo(b)))) {
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
    _shuffleMode = shuffleMode;
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

    final indecesToKeep = [index];
    if (anchorIndex >= 0) {
      indecesToKeep.add(anchorIndex);
    }

    final filteredAvailableSongs = filterAvailableSongs(
      _availableSongs,
      keepIndex: true,
      indeces: indecesToKeep,
      blockLevel: calcBlockLevel(_shuffleMode, _playableSubject.value),
    );
    int newStartIndex = -1;
    if (anchorIndex >= 0) {
      newStartIndex = filteredAvailableSongs.indexOf(anchorItem!);
    } else {
      newStartIndex = filteredAvailableSongs.indexOf(currentQueueItem);
    }

    switch (_shuffleMode) {
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

  Future<List<Song>> updateCurrentIndex(int currentIndex) async {
    _log.d('updateCurrentIndex');
    final int songsAhead = _queue.length - currentIndex - 1;
    int songsToQueue = QUEUE_AHEAD - songsAhead;

    if (songsToQueue > 0) {
      final filteredAvailableSongs = filterAvailableSongs(
        _availableSongs,
        blockLevel: calcBlockLevel(_shuffleMode, _playableSubject.value),
      );
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
        _availableSongsSubject.add(_availableSongs);
        return newSongs.map((e) => e.song).toList();
      }
    }
    return [];
  }

  /// Update songs contained in queue. Return true if any song was changed.
  bool updateSongs(Map<String, Song> songs) {
    _log.d('updateSongs');
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

    // TODO: check if db is fine with that (when frequently changing songs)
    // FIXME: nope, too many changes when skipping through the queue
    if (changed) {
      _queueSubject.add(_queue);
      _availableSongsSubject.add(_availableSongs);
    }

    return changed;
  }

  Future<List<QueueItem>> getQueueItemWithLinks(QueueItem queueItem, List<QueueItem> pool) async {
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

  int getNextNormalIndex(int index) {
    int i = index;

    while (_queue[i].source == QueueItemSource.added) {
      i++;
    }

    return i;
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
    final linkedItems = await getQueueItemWithLinks(queueItems[startIndex], queueItems);
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

      final linkedSong = await getQueueItemWithLinks(locallyAvailableSongs[index], queueItems);
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

      final linkedSong = await getQueueItemWithLinks(bucket[index], queueItems);
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
