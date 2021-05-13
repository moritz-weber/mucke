import '../modules/queue_manager.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/platform_integration_repository.dart';

class RemoveQueueIndex {
  RemoveQueueIndex(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
    this._queueManagerModule,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;

  final QueueManagerModule _queueManagerModule;

  Future<void> call(int index) async {

    _queueManagerModule.removeQueueIndex(index);
    await _audioPlayerRepository.removeQueueIndex(index);

    final songList = _audioPlayerRepository.queueStream.valueWrapper.value;
    print(songList.length);
    _platformIntegrationRepository.setQueue(songList);
  }
}
