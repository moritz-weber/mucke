import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

class ResetLikeCount {
  ResetLikeCount(this._musicDataRepository);

  final MusicDataRepository _musicDataRepository;

  Future<void> call(Song song) async {
    await _musicDataRepository.resetLikeCount(song);
  }
}
