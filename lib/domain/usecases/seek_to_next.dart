import '../repositories/audio_player_repository.dart';

class SeekToNext {
  SeekToNext(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Future<bool> call() async {
    return await _audioPlayerRepository.seekToNext();
  }
}
