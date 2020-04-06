import '../models/song_model.dart';

abstract class AudioManager {
  Future<void> playSong(int index, List<SongModel> songList);
}