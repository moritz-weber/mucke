import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

class SetSongsBlocked {
  SetSongsBlocked(this._musicDataRepository);

  final MusicDataRepository _musicDataRepository;

  Future<void> call(List<Song> songs, int blockLevel) async {
    // TODO: skip to next song automatically?
    await _musicDataRepository.setSongsBlockLevel(songs, blockLevel);
  }
}
