import '../repositories/audio_player_repository.dart';

class Pause {
  Pause(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Future<void> call() async {
    _audioPlayerRepository.pause();
  }
}
