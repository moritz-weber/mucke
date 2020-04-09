import '../models/song_model.dart';

abstract class AudioManager {
  Stream<SongModel> get watchCurrentSong;

  Future<void> playSong(int index, List<SongModel> songList);
}