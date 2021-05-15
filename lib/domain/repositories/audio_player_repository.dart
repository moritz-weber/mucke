import 'package:rxdart/rxdart.dart';

import '../entities/event.dart';
import '../entities/loop_mode.dart';
import '../entities/playback_event.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';

abstract class AudioPlayerInfoRepository {
  Stream<AudioPlayerEvent> eventStream;

  ValueStream<ShuffleMode> get shuffleModeStream;
  ValueStream<LoopMode> get loopModeStream;
  ValueStream<List<Song>> get queueStream;

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
  Future<void> seekToIndex(int index);
  Future<void> dispose();

  /// Create and load a queue from [songs] according to current AudioPlayer settings.
  Future<void> loadSongs({List<Song> songs, int initialIndex});
  Future<void> addToQueue(Song song);
  Future<void> playNext(Song song);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> removeQueueIndex(int index);

  /// Set the ShuffleMode.
  Future<void> setShuffleMode(ShuffleMode shuffleMode, {bool updateQueue});
  Future<void> setLoopMode(LoopMode loopMode);

  /// Current scope: update song information in queue, don't affect playback/queue.
  Future<void> updateSongs(Map<String, Song> songs);
}

class AudioPlayerEvent extends Event {
  AudioPlayerEventType type;
}

enum AudioPlayerEventType { dummy }
