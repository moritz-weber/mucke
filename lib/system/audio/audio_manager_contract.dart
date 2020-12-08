import '../../domain/entities/playback_state.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../models/song_model.dart';

abstract class AudioManager {
  Stream<SongModel> get currentSongStream;
  Stream<PlaybackState> get playbackStateStream;
  Stream<List<SongModel>> get queueStream;
  Stream<int> get queueIndexStream;
  /// Current position in the song in milliseconds.
  Stream<int> get currentPositionStream;
  Stream<ShuffleMode> get shuffleModeStream;

  Future<void> playSong(int index, List<SongModel> songList);
  Future<void> play();
  Future<void> pause();
  Future<void> skipToNext();
  Future<void> skipToPrevious();
  Future<void> setShuffleMode(ShuffleMode shuffleMode);
  Future<void> shuffleAll();
  Future<void> addToQueue(SongModel songModel);
  Future<void> moveQueueItem(int oldIndex, int newIndex);
  Future<void> removeQueueIndex(int index);
}