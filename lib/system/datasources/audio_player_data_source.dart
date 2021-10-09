import 'package:rxdart/rxdart.dart';

import '../../domain/entities/loop_mode.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';

abstract class AudioPlayerDataSource {
  ValueStream<int> get currentIndexStream;
  Stream<PlaybackEventModel> get playbackEventStream;
  ValueStream<bool> get playingStream;
  ValueStream<Duration> get positionStream;

  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<bool> seekToNext();
  Future<void> seekToPrevious();
  Future<void> seekToPosition(double position);
  Future<void> dispose();  // TODO: unused

  Future<void> loadQueue({
    required List<SongModel> queue,
    required int initialIndex,
  });
  Future<void> addToQueue(SongModel song);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> playNext(SongModel song);
  Future<void> removeQueueIndex(int index);
  Future<void> replaceQueueAroundIndex({
    required List<SongModel> before,
    required List<SongModel> after,
    required int index,
  });
  Future<void> seekToIndex(int index);

  Future<void> setLoopMode(LoopMode loopMode);
}
