import '../entities/song.dart';
import '../repositories/music_data_repository.dart';

class IncrementLikeCount {
  IncrementLikeCount(this._musicDataRepository);

  final MusicDataRepository _musicDataRepository;

  Future<void> call(Song song) async {
    await _musicDataRepository.incrementLikeCount(song);
  }
}
