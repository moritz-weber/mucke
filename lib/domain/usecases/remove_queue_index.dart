import '../repositories/audio_player_repository.dart';
import '../repositories/platform_integration_repository.dart';

class RemoveQueueIndex {
  RemoveQueueIndex(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;

  Future<void> call(int index) async {
    await _audioPlayerRepository.removeQueueIndex(index);

    final songList = _audioPlayerRepository.queueStream.valueWrapper.value;
    _platformIntegrationRepository.setQueue(songList);
  }
}
