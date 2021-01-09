import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../models/playback_event_model.dart';
import '../models/queue_item_model.dart';
import '../models/song_model.dart';

abstract class AudioPlayer {
  ValueStream<int> get currentIndexStream;
  ValueStream<SongModel> get currentSongStream;
  Stream<PlaybackEventModel> get playbackEventStream;
  ValueStream<bool> get playingStream;
  ValueStream<Duration> get positionStream;
  ValueStream<List<QueueItemModel>> get queueStream;
  ValueStream<ShuffleMode> get shuffleModeStream;
  ValueStream<LoopMode> get loopModeStream;

  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<bool> seekToNext();
  Future<void> seekToPrevious();
  Future<void> dispose();

  Future<void> loadQueue({List<QueueItemModel> queue, int initialIndex});
  Future<void> addToQueue(SongModel song);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> removeQueueIndex(int index);
  Future<void> setIndex(int index);


  Future<void> setShuffleMode(ShuffleMode shuffleMode, bool updateQueue);
  Future<void> setLoopMode(LoopMode loopMode);

  Future<void> playSongList(List<SongModel> songs, int startIndex);
}
