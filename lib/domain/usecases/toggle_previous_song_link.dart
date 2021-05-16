import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

class TogglePreviousSongLink {
  TogglePreviousSongLink(this._musicDataRepository);

  final MusicDataRepository _musicDataRepository;

  Future<void> call(Song song) async {
    await _musicDataRepository.togglePreviousSongLink(song);
  }
}
