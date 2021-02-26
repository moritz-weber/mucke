import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

class QueueGenerationModule {
  QueueGenerationModule(this._musicDataRepository);

  final MusicDataInfoRepository _musicDataRepository;

  Future<List<QueueItem>> generateQueue(
    ShuffleMode shuffleMode,
    List<Song> songs,
    int startIndex,
  ) async {
    List<QueueItem> queue;

    switch (shuffleMode) {
      case ShuffleMode.none:
        queue = _generateNormalQueue(songs);
        break;
      case ShuffleMode.standard:
        queue = _generateShuffleQueue(songs, startIndex);
        break;
      case ShuffleMode.plus:
        queue = await _generateShufflePlusQueue(songs, startIndex);
    }

    return queue;
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
