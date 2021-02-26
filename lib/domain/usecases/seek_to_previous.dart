import '../repositories/audio_player_repository.dart';

class SeekToPrevious {
  SeekToPrevious(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Future<void> call() async {
    await _audioPlayerRepository.seekToPrevious();
  }
}
