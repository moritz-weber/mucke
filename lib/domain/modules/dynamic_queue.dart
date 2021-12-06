import 'package:rxdart/rxdart.dart';

import '../../system/models/queue_item_model.dart';
import '../../system/models/song_model.dart';
import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../repositories/music_data_repository.dart';
import 'linear_queue_generator.dart';
import 'managed_queue.dart';
import 'queue_generator.dart';
import 'random_queue_generator.dart';
import 'weighted_random_queue_generator.dart';

class DynamicQueue implements ManagedQueueInfo {
  DynamicQueue(this.musicDataRepository) : _queue = [];

  // static final _log = FimberLog('ManagedQueue');

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

  final MusicDataInfoRepository musicDataRepository;

  late QueueGenerator _queueGenerator;

  // this resembles the (so far generated) queue in AudioPlayer
  // QueueItems are needed to determine the original position of the current song
  late List<QueueItem> _queue;
  List<Song> _originalSongs = [];
  List<Song> _addedSongs = [];

  // TODO: need to make these persistent
  List<QueueItem> _filteredQueueItems = [];

  bool _excludeBlocked = true;
  // TODO: should this affect the queue as well? (possibly not yet played but queued songs)
  // NO KNOWLEDGE OF CURRENT INDEX: is this a problem?
  void setExcludeBlocked(bool excludeBlocked) {
    if (excludeBlocked != _excludeBlocked) {
      _excludeBlocked = excludeBlocked;

      if (excludeBlocked) {
        _filteredQueueItems.addAll(_queueGenerator.removeBlocked());
      } else {
        final blocked = List<QueueItem>.from(_filteredQueueItems)
          ..retainWhere(_isBlockedNotSkipped);
        _queueGenerator.addQueueItems(blocked);
        _filteredQueueItems.removeWhere(_isBlockedNotSkipped);
      }
    }
  }

  bool _excludeSkipped = true;
  void setExcludeSkipped(bool excludeSkipped) {
    if (excludeSkipped != _excludeSkipped) {
      _excludeSkipped = excludeSkipped;

      if (excludeSkipped) {
        _filteredQueueItems.addAll(_queueGenerator.removeSkipped(_skipThreshold));
      } else {
        final skipped = List<QueueItem>.from(_filteredQueueItems)
          ..retainWhere(_isSkippedNotBlocked);
        _queueGenerator.addQueueItems(skipped);
        _filteredQueueItems.removeWhere(_isSkippedNotBlocked);
      }
    }
  }

  bool _respectSongLinks = true;
  void setRespectSongLinks(bool respectSongLinks) {
    if (respectSongLinks != _respectSongLinks) {
      _respectSongLinks = respectSongLinks;
      _queueGenerator.respectSongLinks = respectSongLinks;
    }
  }

  int _skipThreshold = 3;
  void setSkipThreshold(int threshold) {
    if (threshold != _skipThreshold) {
      if (threshold > _skipThreshold) {
        final skipped = List<QueueItem>.from(_filteredQueueItems)
          ..retainWhere((e) => _wasSkippedNotBlocked(e, threshold));
        _queueGenerator.addQueueItems(skipped);
        _filteredQueueItems.removeWhere((e) => _wasSkippedNotBlocked(e, threshold));
      } else {
        _filteredQueueItems.addAll(_queueGenerator.removeSkipped(threshold));
      }

      _skipThreshold = threshold;
    }
  }

  void addToQueue(Song song) {
    _addedSongs.add(song);
    _addedSongsSubject.add(_addedSongs);
    final queueItem = QueueItemModel(
      song as SongModel,
      originalIndex: _addedSongs.length - 1,
      source: QueueItemSource.added,
    );
    _queue.add(queueItem);
    _queueItemsSubject.add(_queue);
  }

  void init(
    List<QueueItem> queue,
    List<Song> originalSongs,
    List<Song> addedSongs,
    ShuffleMode shuffleMode,
    List<QueueItem> pool,
    List<QueueItem> filteredItems,
    bool respectSongLinks,
  ) {
    switch (shuffleMode) {
      case ShuffleMode.none:
        _queueGenerator = LinearQueueGenerator(pool, respectSongLinks, musicDataRepository);
        break;
      case ShuffleMode.standard:
        _queueGenerator = RandomQueueGenerator(pool, respectSongLinks, musicDataRepository);
        break;
      case ShuffleMode.plus:
        _queueGenerator = WeightedRandomQueueGenerator(pool, respectSongLinks, musicDataRepository);
        break;
    }
    // no push on subject here to not trigger persistence
    _queue = queue;
    _originalSongs = originalSongs;
    _addedSongs = addedSongs;
  }

  void insertIntoQueue(Song song, int index) {
    _addedSongs.add(song);
    _addedSongsSubject.add(_addedSongs);
    final queueItem = QueueItemModel(
      song as SongModel,
      originalIndex: _addedSongs.length - 1,
      source: QueueItemSource.added,
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
    if (queueItem.source == QueueItemSource.added) {
      _addedSongs.removeAt(queueItem.originalIndex);
      _addedSongsSubject.add(_addedSongs);
    } else if (queueItem.source == QueueItemSource.original) {
      _originalSongs.removeAt(queueItem.originalIndex);
      _originalSongsSubject.add(_originalSongs);
    }

    for (int i = 0; i < queueItemList.length; i++) {
      if (queueItemList[i].source == queueItem.source &&
          queueItemList[i].originalIndex > queueItem.originalIndex) {
        queueItemList[i] = QueueItemModel(
          queueItemList[i].song as SongModel,
          originalIndex: queueItemList[i].originalIndex - 1,
          source: queueItemList[i].source,
        );
      }
    }

    _queue.removeAt(index);
    _queueItemsSubject.add(_queue);
  }

  // this is the motivation behind all the original/added songs and queueitems:
  // to regenerate the original queue, we need the the original song list
  // and the position of the current song in this original song list
  /// Returns the new index of the current song.
  Future<int> reshuffleQueue(
    ShuffleMode shuffleMode,
    int currentIndex,
  ) async {
    final songs = _originalSongs.cast<Song>() + _addedSongs;
    final currentQueueItem = _queue[currentIndex];
    int originalIndex = currentQueueItem.originalIndex;
    if (currentQueueItem.source == QueueItemSource.added) {
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

  /// Update songs contained in queue. Return true if any song was changed.
  bool updateSongs(Map<String, Song> songs) {
    bool changed = false;

    for (int i = 0; i < _queue.length; i++) {
      if (songs.containsKey(_queue[i].song.path)) {
        _queue[i] = (_queue[i] as QueueItemModel).copyWith(
          song: songs[_queue[i].song.path]! as SongModel,
        );
        changed = true;
      }
    }

    for (int i = 0; i < _originalSongs.length; i++) {
      if (songs.containsKey(_originalSongs[i].path)) {
        _originalSongs[i] = songs[_originalSongs[i].path]!;
      }
    }

    for (int i = 0; i < _addedSongs.length; i++) {
      if (songs.containsKey(_addedSongs[i].path)) {
        _addedSongs[i] = songs[_addedSongs[i].path]!;
      }
    }

    return changed;
  }

  Future<int> addSongsFromPool(int number) async {
    final songs = await _queueGenerator.generate(number);

    _queue.addAll(songs);

    return songs.length;
  }

  Future<int> _generateQueue(
    ShuffleMode shuffleMode,
    List<Song> songs,
    int startIndex,
  ) async {
    final queueItems = List<QueueItem>.generate(
      songs.length,
      (i) => QueueItemModel(
        songs[i] as SongModel,
        originalIndex: i,
      ),
    );

    // due to the filtering, the original startIndex may be incorrect
    int newStartIndex = startIndex;

    // TODO: brauchen wir das jedes Mal oder geht das effizienter?
    _filteredQueueItems = [];
    int i = 0;
    while (i < queueItems.length) {
      if (_excludeBlocked && queueItems[i].song.blocked) {
        _filteredQueueItems.add(queueItems.removeAt(i));
        if (i < newStartIndex) newStartIndex--;
      } else if (_excludeSkipped && queueItems[i].song.skipCount >= _skipThreshold) {
        _filteredQueueItems.add(queueItems.removeAt(i));
        if (i < newStartIndex) newStartIndex--;
      } else {
        i++;
      }
    }

    switch (shuffleMode) {
      case ShuffleMode.none:
        return _generateNormalQueue(queueItems, newStartIndex);
      case ShuffleMode.standard:
        return await _generateShuffleQueue(queueItems, newStartIndex);
      case ShuffleMode.plus:
        return await _generateShufflePlusQueue(queueItems, newStartIndex);
    }
  }

  Future<int> _generateNormalQueue(List<QueueItem> queueItems, int startIndex) async {
    _queueGenerator = LinearQueueGenerator(queueItems, _respectSongLinks, musicDataRepository);
    _queue = await _queueGenerator.generate(startIndex + 199);
    _queueItemsSubject.add(_queue);
    return startIndex;
  }

  Future<int> _generateShuffleQueue(List<QueueItem> queueItems, int startIndex) async {
    _queueGenerator = RandomQueueGenerator(queueItems, _respectSongLinks, musicDataRepository);

    final List<QueueItem> queue =
        await _queueGenerator.getQueueItemWithLinks(queueItems[startIndex]);

    _queueGenerator.removeQueueItems(queue);

    queue.addAll(await _queueGenerator.generate(199));

    _queue = queue.cast();
    _queueItemsSubject.add(_queue);
    return 0;
  }

  Future<int> _generateShufflePlusQueue(List<QueueItem> queueItems, int startIndex) async {
    _queueGenerator = WeightedRandomQueueGenerator(
      queueItems,
      _respectSongLinks,
      musicDataRepository,
    );

    final List<QueueItem> queue =
        await _queueGenerator.getQueueItemWithLinks(queueItems[startIndex]);

    _queueGenerator.removeQueueItems(queue);

    queue.addAll(await _queueGenerator.generate(199));

    _queue = queue.cast();
    _queueItemsSubject.add(_queue);
    return 0;
  }

  bool _isSkippedNotBlocked(QueueItem queueItem) {
    return queueItem.song.skipCount >= _skipThreshold &&
        (!_excludeBlocked || !queueItem.song.blocked);
  }

  bool _wasSkippedNotBlocked(QueueItem queueItem, int newThreshold) {
    return queueItem.song.skipCount >= _skipThreshold &&
        queueItem.song.skipCount < newThreshold &&
        (!_excludeBlocked || !queueItem.song.blocked);
  }

  bool _isBlockedNotSkipped(QueueItem queueItem) {
    return queueItem.song.blocked &&
        (!_excludeSkipped || queueItem.song.skipCount < _skipThreshold);
  }
}
