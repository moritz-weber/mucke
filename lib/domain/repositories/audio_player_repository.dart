import 'package:rxdart/rxdart.dart';

import '../entities/loop_mode.dart';
import '../entities/playback_event.dart';
import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../modules/managed_queue.dart';

abstract class AudioPlayerInfoRepository {
  ValueStream<ShuffleMode> get shuffleModeStream;
  ValueStream<LoopMode> get loopModeStream;
  ValueStream<bool> get excludeBlockedStream;
  ValueStream<bool> get excludeSkippedStream;
  ValueStream<bool> get respectSongLinksStream;
  ValueStream<List<Song>> get queueStream;

  ValueStream<int> get currentIndexStream;
  Stream<Song> get currentSongStream;
  Stream<PlaybackEvent> get playbackEventStream;
  Stream<bool> get playingStream;
  Stream<Duration> get positionStream;

  ManagedQueueInfo get managedQueueInfo;
}

abstract class AudioPlayerRepository extends AudioPlayerInfoRepository {
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<bool> seekToNext();
  Future<void> seekToPrevious();
  Future<void> seekToIndex(int index);
  /// Seek to a relative position of the current track.
  Future<void> seekToPosition(double position);
  // Future<void> dispose();  // TODO: unused

  Future<void> initQueue(
    List<QueueItem> queueItems,
    List<Song> originalSongs,
    List<Song> addedSongs,
    int index,
  );

  /// Create and load a queue from [songs] according to current AudioPlayer settings.
  Future<void> loadSongs({
    required List<Song> songs,
    required int initialIndex,
  });
  Future<void> addToQueue(Song song);
  Future<void> playNext(Song song);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> removeQueueIndex(int index);

  /// Set the ShuffleMode.
  Future<void> setShuffleMode(ShuffleMode shuffleMode, {bool updateQueue});
  Future<void> setLoopMode(LoopMode loopMode);
  Future<void> setExcludeBlocked(bool enabled);
  Future<void> setExcludeSkipped(bool enabled);
  Future<void> setRespectSongLinks(bool enabled);

  /// Current scope: update song information in queue, don't affect playback/queue.
  Future<void> updateSongs(Map<String, Song> songs);
}
