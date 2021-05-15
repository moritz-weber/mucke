import '../entities/shuffle_mode.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/persistent_player_state_repository.dart';
import '../repositories/platform_integration_repository.dart';

class SetShuffleMode {
  SetShuffleMode(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
    this._playerStateRepository,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;
  final PersistentStateRepository _playerStateRepository;

  Future<void> call(ShuffleMode shuffleMode, {bool updateQueue = true}) async {
    await _audioPlayerRepository.setShuffleMode(shuffleMode, updateQueue: updateQueue);

    if (updateQueue) {
      _platformIntegrationRepository.setQueue(
        _audioPlayerRepository.queueStream.valueWrapper.value,
      );
    }
    _playerStateRepository.setShuffleMode(shuffleMode);
  }
}
