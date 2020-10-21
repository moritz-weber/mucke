import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../datasources/music_data_source_contract.dart';
import '../models/queue_item.dart';
import '../models/song_model.dart';

class QueueGenerator {
  QueueGenerator(this._musicDataSource);

  final MusicDataSource _musicDataSource;

  // TODO: test
  // TODO: optimize -> too slow for whole library
  // fetching all songs together and preparing playback takes ~500ms compared to ~10.000ms individually
  Future<List<MediaItem>> getMediaItemsFromPaths(List<String> paths) async {
    final mediaItems = <MediaItem>[];
    for (final path in paths) {
      final song = await _musicDataSource.getSongByPath(path);
      mediaItems.add(song.toMediaItem());
    }

    return mediaItems;
  }

  Future<List<QueueItem>> generateQueue(
    ShuffleMode shuffleMode,
    List<MediaItem> mediaItems,
    int startIndex,
  ) async {
    List<QueueItem> queue;

    switch (shuffleMode) {
      case ShuffleMode.none:
        queue = _generateNormalQueue(mediaItems);
        break;
      case ShuffleMode.standard:
        queue = _generateShuffleQueue(mediaItems, startIndex);
        break;
      case ShuffleMode.plus:
        queue = await _generateShufflePlusQueue(mediaItems, startIndex);
    }

    return queue;
  }

  ConcatenatingAudioSource mediaItemsToAudioSource(List<MediaItem> mediaItems) {
    return ConcatenatingAudioSource(
        children: mediaItems
            .map((MediaItem m) => AudioSource.uri(Uri.file(m.id)))
            .toList());
  }

  List<QueueItem> _generateNormalQueue(List<MediaItem> mediaItems) {
    return List<QueueItem>.generate(
      mediaItems.length,
      (i) => QueueItem(
        mediaItems[i],
        originalIndex: i,
      ),
    );
  }

  List<QueueItem> _generateShuffleQueue(
    List<MediaItem> mediaItems,
    int startIndex,
  ) {
    final List<QueueItem> queue = List<QueueItem>.generate(
      mediaItems.length,
      (i) => QueueItem(
        mediaItems[i],
        originalIndex: i,
      ),
    );
    queue.removeAt(startIndex);
    queue.shuffle();
    final first = QueueItem(
      mediaItems[startIndex],
      originalIndex: startIndex,
    );
    return [first] + queue;
  }

  Future<List<QueueItem>> _generateShufflePlusQueue(
    List<MediaItem> mediaItems,
    int startIndex,
  ) async {
    final List<QueueItem> queue = await _getQueueItemWithLinks(
      mediaItems[startIndex],
      startIndex,
    );
    final List<int> indices = [];

    // filter mediaitem list
    // TODO: multiply higher rated songs
    for (var i = 0; i < mediaItems.length; i++) {
      if (i != startIndex && !(mediaItems[i].extras['blocked'] as bool)) {
        indices.add(i);
      }
    }

    indices.shuffle();

    for (var i = 0; i < indices.length; i++) {
      final int index = indices[i];
      final MediaItem mediaItem = mediaItems[index];

      queue.addAll(await _getQueueItemWithLinks(mediaItem, index));
    }

    return queue;
  }

  // TODO: naming things is hard
  Future<List<QueueItem>> _getQueueItemWithLinks(
    MediaItem mediaItem,
    int index,
  ) async {
    final List<QueueItem> queueItems = [];

    final predecessors = await _getPredecessors(mediaItem);
    final successors = await _getSuccessors(mediaItem);

    for (final p in predecessors) {
      queueItems.add(QueueItem(
        p,
        originalIndex: index,
        type: QueueItemType.predecessor,
      ));
    }

    queueItems.add(QueueItem(
      mediaItem,
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

  Future<List<MediaItem>> _getPredecessors(MediaItem mediaItem) async {
    final List<MediaItem> mediaItems = [];
    MediaItem currentMediaItem = mediaItem;

    while (currentMediaItem.previous != null) {
      currentMediaItem =
          (await _musicDataSource.getSongByPath(currentMediaItem.previous))
              .toMediaItem();
      mediaItems.add(currentMediaItem);
    }

    return mediaItems.reversed.toList();
  }

  Future<List<MediaItem>> _getSuccessors(MediaItem mediaItem) async {
    final List<MediaItem> mediaItems = [];
    MediaItem currentMediaItem = mediaItem;

    while (currentMediaItem.next != null) {
      currentMediaItem =
          (await _musicDataSource.getSongByPath(currentMediaItem.next))
              .toMediaItem();
      mediaItems.add(currentMediaItem);
    }

    return mediaItems.toList();
  }
}
