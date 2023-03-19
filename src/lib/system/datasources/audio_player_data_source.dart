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
  Future<void> addToQueue(List<SongModel> songs);
  Future<void> insertIntoQueue(List<SongModel> songs, int index);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> playNext(List<SongModel> songs);
  Future<void> removeQueueIndices(List<int> indices);
  Future<void> replaceQueueAroundIndex({
    required List<SongModel> before,
    required List<SongModel> after,
    required int index,
  });
  Future<void> seekToIndex(int index);

  Future<void> setLoopMode(LoopMode loopMode);

  /// Calculate the new current index when moving a song from [oldIndex] to [newIndex].
  int calcNewCurrentIndexOnMove(int currentIndex, int oldIndex, int newIndex);
}
