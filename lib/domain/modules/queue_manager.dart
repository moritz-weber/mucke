import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

class QueueManagerModule {
  QueueManagerModule(this._musicDataRepository);

  List<QueueItem> get queue => _queue;

  final MusicDataInfoRepository _musicDataRepository;

  List<Song> _originalSongList = [];
  List<Song> _addedSongs = [];
  // this resembles the queue in AudioPlayer
  List<QueueItem> _queue;

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

    if (queueItem.type == QueueItemType.added) {
      _addedSongs.removeAt(queueItem.originalIndex);
    } else if (queueItem.type == QueueItemType.standard) {
      _originalSongList.removeAt(queueItem.originalIndex);
    }

    for (int i = 0; i < queue.length; i++) {
      if (queue[i].type == queueItem.type && queue[i].originalIndex > queueItem.originalIndex) {
        queue[i] = QueueItem(
          queue[i].song,
          originalIndex: queue[i].originalIndex - 1,
          type: queue[i].type,
        );
      }
    }

    _queue.removeAt(index);
  }

  Future<void> reshuffleQueue(
    ShuffleMode shuffleMode,
    int currentIndex,
  ) async {
    final songs = _originalSongList + _addedSongs;
    final currentQueueItem = _queue[currentIndex];
    int originalIndex = currentQueueItem.originalIndex;
    if (currentQueueItem.type == QueueItemType.added) {
      originalIndex += _originalSongList.length;
    }

    _queue = await _generateQueue(shuffleMode, songs, originalIndex);
  }

  Future<void> setQueue(
    ShuffleMode shuffleMode,
    List<Song> songs,
    int startIndex,
  ) async {
    _originalSongList = songs;
    _addedSongs = [];

    _queue = await _generateQueue(shuffleMode, songs, startIndex);
  }

  // ignore: missing_return
  Future<List<QueueItem>> _generateQueue(
    ShuffleMode shuffleMode,
    List<Song> songs,
    int startIndex,
  ) async {
    switch (shuffleMode) {
      case ShuffleMode.none:
        return _generateNormalQueue(songs);
      case ShuffleMode.standard:
        return _generateShuffleQueue(songs, startIndex);
      case ShuffleMode.plus:
        return await _generateShufflePlusQueue(songs, startIndex);
    }
  }

  List<QueueItem> _generateNormalQueue(List<Song> songs) {
    return List<QueueItem>.generate(
      songs.length,
      (i) => QueueItem(
        songs[i],
        originalIndex: i,
      ),
    );
  }

  List<QueueItem> _generateShuffleQueue(
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
    return [first] + queue;
  }

  Future<List<QueueItem>> _generateShufflePlusQueue(
    List<Song> songs,
    int startIndex,
  ) async {
    final List<QueueItem> queue = await _getQueueItemWithLinks(
      songs[startIndex],
      startIndex,
    );
    final List<int> indices = [];

    // filter mediaitem list
    // TODO: multiply higher rated songs
    for (var i = 0; i < songs.length; i++) {
      if (i != startIndex && !songs[i].blocked) {
        indices.add(i);
      }
    }

    indices.shuffle();

    for (var i = 0; i < indices.length; i++) {
      final int index = indices[i];
      final Song song = songs[index];

      queue.addAll(await _getQueueItemWithLinks(song, index));
    }

    return queue;
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
}
