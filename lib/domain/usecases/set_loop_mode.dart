import '../entities/loop_mode.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/persistent_player_state_repository.dart';

class SetLoopMode {
  SetLoopMode(this._audioPlayerRepository, this._persistentStateRepository);

  final AudioPlayerRepository _audioPlayerRepository;
  final PersistentStateRepository _persistentStateRepository;

  Future<void> call(LoopMode loopMode) async {
    await _audioPlayerRepository.setLoopMode(loopMode);
    _persistentStateRepository.setLoopMode(loopMode);
  }
}
