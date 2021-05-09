import '../entities/song.dart';
import '../modules/queue_manager.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/persistent_player_state_repository.dart';
import '../repositories/platform_integration_repository.dart';

class AddToQueue {
  AddToQueue(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
    this._playerStateRepository,
    this._queueManagerModule,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;
  final PlayerStateRepository _playerStateRepository;

  final QueueManagerModule _queueManagerModule;

  Future<void> call(Song song) async {

    _queueManagerModule.addToQueue(song);
    await _audioPlayerRepository.addToQueue(song);

    final songList = _audioPlayerRepository.queueStream.valueWrapper.value;
    print(songList.length);
    _platformIntegrationRepository.setQueue(songList);
  }
}
