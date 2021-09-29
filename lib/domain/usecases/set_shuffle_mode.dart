import '../entities/shuffle_mode.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/platform_integration_repository.dart';

class SetShuffleMode {
  SetShuffleMode(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;

  Future<void> call(ShuffleMode shuffleMode, {bool updateQueue = true}) async {
    await _audioPlayerRepository.setShuffleMode(shuffleMode, updateQueue: updateQueue);

    if (updateQueue) {
      _platformIntegrationRepository.setQueue(
        _audioPlayerRepository.queueStream.value,
      );
    }
  }
}
