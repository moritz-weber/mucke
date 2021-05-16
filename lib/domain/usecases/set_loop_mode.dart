import '../entities/loop_mode.dart';
import '../repositories/audio_player_repository.dart';

class SetLoopMode {
  SetLoopMode(this._audioPlayerRepository);

  final AudioPlayerRepository _audioPlayerRepository;

  Future<void> call(LoopMode loopMode) async {
    await _audioPlayerRepository.setLoopMode(loopMode);
  }
}
