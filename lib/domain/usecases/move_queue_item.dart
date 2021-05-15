import '../repositories/audio_player_repository.dart';
import '../repositories/platform_integration_repository.dart';

class MoveQueueItem {
  MoveQueueItem(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;

  Future<void> call(int oldIndex, int newIndex) async {
    await _audioPlayerRepository.moveQueueItem(oldIndex, newIndex);

    final songList = _audioPlayerRepository.queueStream.valueWrapper.value;
    _platformIntegrationRepository.setQueue(songList);
  }
}
