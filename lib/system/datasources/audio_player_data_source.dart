import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';

abstract class AudioPlayerDataSource {
  ValueStream<int> get currentIndexStream;
  // ValueStream<SongModel> get currentSongStream;
  Stream<PlaybackEventModel> get playbackEventStream;
  ValueStream<bool> get playingStream;
  ValueStream<Duration> get positionStream;

  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<bool> seekToNext();
  Future<void> seekToPrevious();
  Future<void> dispose();

  Future<void> loadQueue({List<SongModel> queue, int initialIndex});
  Future<void> addToQueue(SongModel song);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> playNext(SongModel song);
  Future<void> removeQueueIndex(int index);
  Future<void> replaceQueueAroundIndex({List<SongModel> before, List<SongModel> after, int index});
  Future<void> seekToIndex(int index);

  Future<void> setLoopMode(LoopMode loopMode);
}
