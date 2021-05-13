import '../modules/queue_manager.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/platform_integration_repository.dart';

class MoveQueueItem {
  MoveQueueItem(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
    this._queueManagerModule,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;

  final QueueManagerModule _queueManagerModule;

  Future<void> call(int oldIndex, int newIndex) async {

    _queueManagerModule.moveQueueItem(oldIndex, newIndex);
    await _audioPlayerRepository.moveQueueItem(oldIndex, newIndex);

    final songList = _audioPlayerRepository.queueStream.valueWrapper.value;
    _platformIntegrationRepository.setQueue(songList);
  }
}
