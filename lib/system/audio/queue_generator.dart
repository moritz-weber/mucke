import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../datasources/music_data_source_contract.dart';
import '../models/queue_item.dart';
import '../models/song_model.dart';

class QueueGenerator {
  QueueGenerator(this._musicDataSource);

  final MusicDataSource _musicDataSource;

  Future<List<QueueItem>> generateQueue(
    ShuffleMode shuffleMode,
    List<SongModel> songModels,
    int startIndex,
  ) async {
    List<QueueItem> queue;

    switch (shuffleMode) {
      case ShuffleMode.none:
        queue = _generateNormalQueue(songModels);
        break;
      case ShuffleMode.standard:
        queue = _generateShuffleQueue(songModels, startIndex);
        break;
      case ShuffleMode.plus:
        queue = await _generateShufflePlusQueue(songModels, startIndex);
    }

    return queue;
  }

  ConcatenatingAudioSource mediaItemsToAudioSource(List<MediaItem> mediaItems) {
    return ConcatenatingAudioSource(
      children: mediaItems.map((MediaItem m) => AudioSource.uri(Uri.file(m.id))).toList(),
    );
  }

  ConcatenatingAudioSource songModelsToAudioSource(List<SongModel> songModels) {
    return ConcatenatingAudioSource(
      children: songModels.map((SongModel m) => AudioSource.uri(Uri.file(m.path))).toList(),
    );
  }

  List<QueueItem> _generateNormalQueue(List<SongModel> songs) {
    return List<QueueItem>.generate(
      songs.length,
      (i) => QueueItem(
        songs[i],
        originalIndex: i,
      ),
    );
  }

  List<QueueItem> _generateShuffleQueue(
    List<SongModel> songs,
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
    List<SongModel> songs,
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
      final SongModel song = songs[index];

      queue.addAll(await _getQueueItemWithLinks(song, index));
    }

    return queue;
  }

  // TODO: naming things is hard
  Future<List<QueueItem>> _getQueueItemWithLinks(
    SongModel song,
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

  Future<List<SongModel>> _getPredecessors(SongModel song) async {
    final List<SongModel> songs = [];
    SongModel currentSong = song;

    while (currentSong.previous != null) {
      currentSong = await _musicDataSource.getSongByPath(currentSong.previous);
      songs.add(currentSong);
    }

    return songs.reversed.toList();
  }

  Future<List<SongModel>> _getSuccessors(SongModel song) async {
    final List<SongModel> songs = [];
    SongModel currentSong = song;

    while (currentSong.next != null) {
      currentSong = await _musicDataSource.getSongByPath(currentSong.next);
      songs.add(currentSong);
    }

    return songs.toList();
  }
}
