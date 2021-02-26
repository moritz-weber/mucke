import 'package:rxdart/rxdart.dart';

import '../entities/event.dart';
import '../entities/loop_mode.dart';
import '../entities/playback_event.dart';
import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';

abstract class AudioPlayerInfoRepository {
  Stream<AudioPlayerEvent> eventStream;

  ValueStream<ShuffleMode> get shuffleModeStream;
  ValueStream<LoopMode> get loopModeStream;
  ValueStream<List<Song>> get songListStream;
  ValueStream<List<QueueItem>> get queueStream;

  ValueStream<int> get currentIndexStream;
  Stream<Song> get currentSongStream;
  Stream<PlaybackEvent> get playbackEventStream;
  Stream<bool> get playingStream;
  Stream<Duration> get positionStream;
}

abstract class AudioPlayerRepository extends AudioPlayerInfoRepository {
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<bool> seekToNext();
  Future<void> seekToPrevious();
  Future<void> dispose();

  Future<void> playSong(Song song);
  Future<void> loadQueue({List<QueueItem> queue, int initialIndex});
  Future<void> addToQueue(Song song);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> removeQueueIndex(int index);
  Future<void> setIndex(int index);

  /// Set the ShuffleMode. Does not affect playback/queue.
  Future<void> setShuffleMode(ShuffleMode shuffleMode);
  Future<void> setLoopMode(LoopMode loopMode);
}

class AudioPlayerEvent extends Event {
  AudioPlayerEventType type;
}

enum AudioPlayerEventType { dummy }
