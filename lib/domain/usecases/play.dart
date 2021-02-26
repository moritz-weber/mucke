import '../repositories/audio_player_repository.dart';

class Play {
  Play(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Future<void> call() async {
    _audioPlayerRepository.play();
  }
}
