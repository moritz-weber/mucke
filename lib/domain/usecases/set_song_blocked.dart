import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

class SetSongBlocked {
  SetSongBlocked(this._musicDataRepository);

  final MusicDataRepository _musicDataRepository;

  Future<void> call(Song song, int blockLevel) async {
    // TODO: skip to next song automatically?
    await _musicDataRepository.setSongBlockLevel(song, blockLevel);
  }
}
