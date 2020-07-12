import '../../domain/entities/playback_state.dart';
import '../models/song_model.dart';

abstract class AudioManager {
  Stream<SongModel> get currentSongStream;
  Stream<PlaybackState> get playbackStateStream;
  Stream<List<SongModel>> get queueStream;
  Stream get customEventStream;
  Stream<int> get queueIndexStream;
  /// Current position in the song in milliseconds.
  Stream<int> get currentPositionStream;

  Future<void> playSong(int index, List<SongModel> songList);
  Future<void> play();
  Future<void> pause();
  Future<void> skipToNext();
  Future<void> skipToPrevious();
}