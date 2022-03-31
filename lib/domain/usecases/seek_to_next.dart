import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';

class SeekToNext {
  SeekToNext(this._audioPlayerRepository, this._musicDataRepository);

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;

  Future<bool> call() async {
    final song = await _audioPlayerRepository.currentSongStream.first;
    final hasNext = await _audioPlayerRepository.seekToNext();
    if (hasNext && song != null) _musicDataRepository.incrementSkipCount(song);
    return hasNext;
  }
}
