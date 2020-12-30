import '../entities/loop_mode.dart';
import '../entities/playback_state.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';

abstract class AudioRepository {
  Stream<Song> get currentSongStream;
  Stream<PlaybackState> get playbackStateStream;
  Stream<int> get currentPositionStream;

  Future<void> playSong(int index, List<Song> songList);
  Future<void> play();
  Future<void> pause();
  Future<void> skipToNext();
  Future<void> skipToPrevious();
  Future<void> setIndex(int index);

  Future<void> setShuffleMode(ShuffleMode shuffleMode);
  Future<void> setLoopMode(LoopMode loopMode);

  Future<void> shuffleAll();
  Future<void> addToQueue(Song song);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> removeQueueIndex(int index);
}
