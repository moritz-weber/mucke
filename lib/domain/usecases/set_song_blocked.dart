import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

class SetSongBlocked {
  SetSongBlocked(this._musicDataRepository);

  final MusicDataRepository _musicDataRepository;

  Future<void> call(Song song, bool blocked) async {
    await _musicDataRepository.setSongBlocked(song, blocked);
  }
}
