import 'dart:math';

import '../../constants.dart';
import '../../system/models/queue_item_model.dart';
import '../../system/models/song_model.dart';
import '../entities/playable.dart';
import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

const int QUEUE_AHEAD = 50;

// Notizen zu filter / reshuffle
// für reshuffle ist nur nötig:
// * originale Reihenfolge (bleibt in _availableSongs erhalten)
// * position des aktuellen Songs in der originalen Reihenfolge

// X queue kennt Typ+ID der Wiedergabe, bspw: Album, All, Artist, Search, Playlist, Smartlist
// X queue kennt Wiedergabemodus: Shuffle,...
// X Filter (block) sind fix: 3 Modi für unterschiedliche Situationen
//   - dadurch auch keine Änderungen, die sich auf queue auswirken könnten
//   - dafür sind Typ und Modus nötig
//   - Einstellung von Smartlist könnte das überschreiben
// X Queue wird nicht aktualisiert, wenn sich SmartList ändert -> könnte in Zukunft manuell geschehen
// X Skip-Block gibt's nicht
// - respectSongLinks richtig handlen
// - Reaktionen auf Song-Änderungen: erstmal nur, wenn geblockt wird -> entfernen
// - Bonus-Reaktion: wenn Song aus/zu Playlist entfernt/hinzugefügt wird
// ** WELCHE SONG-LISTE WIRD ÜBERGEBEN? **
//   X muss die queue selber filtern? eigentlich schon, aber wird auch einfacher, weil sich das nicht ändert
//   X müsste halt auf ShuffleMode-Änderungen reagieren

class DynamicQueue2 {
  DynamicQueue2(
    this._musicDataRepository,
  ) {
    _availableSongs = [];
    _queue = [];
  }

  final MusicDataRepository _musicDataRepository;

  List<Song> get queue => _queue.map((e) => e.song).toList();
  // WHY IS/WAS THIS REQUIRED? FILTERED SONGS SHOULDN'T BE IN _queue
  // List<Song> get queue => _filterAvailableSongs(_queue).map((e) => e.song).toList();
  late List<QueueItem> _queue;
  late List<QueueItem> _availableSongs;

  Playable? _playable;
  ShuffleMode _shuffleMode = ShuffleMode.none;

  Future<int> generateQueue(List<Song> songs, Playable playable, int startIndex, ShuffleMode shuffleMode) async {
    _shuffleMode = shuffleMode;
    _playable = playable;
    
    _availableSongs = List.generate(
      songs.length,
      (i) => QueueItemModel(songs[i] as SongModel, originalIndex: i),
    );

    final initialQueueItem = _availableSongs[startIndex];

    final filteredAvailableSongs = _filterAvailableSongs(_availableSongs);
    final newStartIndex = filteredAvailableSongs.indexOf(initialQueueItem);

    switch (_shuffleMode) {
      case ShuffleMode.none:
        return _generateNormalQueue(filteredAvailableSongs, newStartIndex);
      case ShuffleMode.standard:
        return await _generateShuffleQueue(filteredAvailableSongs, newStartIndex);
      case ShuffleMode.plus:
        return await _generateShufflePlusQueue(filteredAvailableSongs, newStartIndex);
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
    _queue.add(queueItem);
  }

  void insertIntoQueue(Song song, int index) {
    final queueItem = QueueItemModel(
      song as SongModel,
      originalIndex: _availableSongs.length, // interference with predecessors/successors?
      source: QueueItemSource.added,
      isAvailable: false,
    );

    _availableSongs.add(queueItem);
    _queue.insert(index, queueItem);
  }

  void moveQueueItem(int oldIndex, int newIndex) {
    _queue.insert(newIndex, _queue.removeAt(oldIndex));
  }

  void removeQueueIndex(int index) {
    final queueItem = _queue[index];

    // if a song is removed from the queue, it should not pop up again when reshuffling
    _availableSongs.remove(queueItem);

    // this needs to update originalIndex
    for (int i = 0; i < _availableSongs.length; i++) {
      if (_availableSongs[i].originalIndex > queueItem.originalIndex) {
        _availableSongs[i].originalIndex -= 1;
      }
    }

    _queue.removeAt(index);
  }

  Future<int> reshuffleQueue(ShuffleMode shuffleMode, int currentIndex) async {
    _shuffleMode = shuffleMode;
    final currentQueueItem = _queue[currentIndex];

    // TODO: need  to make songs available // WHAT?
    final filteredAvailableSongs = _filterAvailableSongs(_availableSongs);
    // TODO: what if the item is not in the filtered list?
    final newStartIndex = filteredAvailableSongs.indexOf(currentQueueItem);

    switch (_shuffleMode) {
      case ShuffleMode.none:
        return _generateNormalQueue(filteredAvailableSongs, newStartIndex);
      case ShuffleMode.standard:
        return await _generateShuffleQueue(filteredAvailableSongs, newStartIndex);
      case ShuffleMode.plus:
        return await _generateShufflePlusQueue(filteredAvailableSongs, newStartIndex);
    }
  }

  Future<List<Song>> drawFromAvailableSongs(int numberOfSongs) async {
    return [];
  }

  /// Update songs contained in queue. Return true if any song was changed.
  bool updateSongs(Map<String, Song> songs) {
    return false;
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

    int blockLevel = 2;  // exclude songs with highest block level
    if (_shuffleMode != ShuffleMode.none) {
      if (_playable?.type == PlayableType.all) {
        blockLevel = 0;  // shuffling all songs -> strictest setting
      } else {
        blockLevel = 1;
      }
    }

    for (int i = 0; i < availableSongs.length; i++) {
      final qi = availableSongs[i];
      if (!(qi.song.blockLevel > blockLevel)) {
        result.add(qi);
      } else {
        print('blocked: ${qi.song.title}');
      }
    }

    return availableSongs;
  }

  Future<int> _generateNormalQueue(List<QueueItem> queueItems, int startIndex) async {
    final max = min(startIndex + QUEUE_AHEAD, queueItems.length);

    for (int i = 0; i < max; i++) queueItems[i].isAvailable = false;

    _queue = queueItems.sublist(0, max);
    return startIndex;
  }

  Future<int> _generateShuffleQueue(List<QueueItem> queueItems, int startIndex) async {
    final Random _rnd = Random();
    // keeping this list makes iterating the available songs easier
    final locallyAvailableSongs = List<QueueItem>.from(queueItems);

    final List<QueueItem> queue = [];
    // if (respectSongLinks) {
    final linkedItems = await getQueueItemWithLinks(queueItems[startIndex]);
    // TODO: need to add those to the _availableSongs?
    queue.addAll(linkedItems);
    // } else {
    //   queue.add(queueItems[startIndex]);
    // }
    // don't want to select these songs twice
    queue.forEach(locallyAvailableSongs.remove);

    while (queue.length < QUEUE_AHEAD && locallyAvailableSongs.isNotEmpty) {
      final index = _rnd.nextInt(locallyAvailableSongs.length);

      // if (respectSongLinks) {
      final linkedSong = await getQueueItemWithLinks(locallyAvailableSongs[index]);
      queue.addAll(linkedSong);
      if (linkedSong.length > 1) {
        linkedSong.forEach((q) => locallyAvailableSongs.removeWhere((e) => e.song == q.song));
      } else {
        locallyAvailableSongs.removeAt(index);
      }
      // } else {
      //   queue.add(locallyAvailableSongs.removeAt(index));
      // }
    }

    // these qi are the same objects as in _availableSongs -> marks them to not be queued (again)
    queue.forEach((qi) {
      qi.isAvailable = false;
    });
    _queue = queue.cast();
    return 0;
  }

  Future<int> _generateShufflePlusQueue(List<QueueItem> queueItems, int startIndex) async {
    final Random _rnd = Random();
    final List<List<QueueItem>> buckets = List.generate(MAX_LIKE_COUNT + 1, (index) => []);

    for (final qi in queueItems) {
      buckets[qi.song.likeCount].add(qi);
    }

    final List<QueueItem> queue = [];
    // if (respectSongLinks) {
    final linkedItems = await getQueueItemWithLinks(queueItems[startIndex]);
    queue.addAll(linkedItems);
    // } else {
    //   queue.add(queueItems[startIndex]);
    // }
    // don't want to select these songs twice
    for (final qi in queue) {
      buckets[qi.song.likeCount].remove(qi);
    }

    while (queue.length < QUEUE_AHEAD && buckets.expand((e) => e).isNotEmpty) {
      final bucketIndex = _getBucketIndex(buckets);
      final bucket = buckets[bucketIndex];

      final index = _rnd.nextInt(bucket.length);

      // if (respectSongLinks) {
      final linkedSong = await getQueueItemWithLinks(bucket[index]);
      queue.addAll(linkedSong);
      if (linkedSong.length > 1) {
        for (final q in linkedSong) {
          buckets[q.song.likeCount].removeWhere((e) => e.song == q.song);
        }
      } else {
        bucket.removeAt(index);
      }
      // } else {
      //   queue.add(bucket.removeAt(index));
      // }
    }

    queue.forEach((qi) {
      qi.isAvailable = false;
    });
    _queue = queue.cast();
    return 0;
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
