import '../../domain/entities/playback_state.dart';
import '../models/song_model.dart';

abstract class AudioManager {
  Stream<SongModel> get currentSongStream;
  Stream<PlaybackState> get playbackStateStream;

  Future<void> playSong(int index, List<SongModel> songList);
  Future<void> play();
  Future<void> pause();
}