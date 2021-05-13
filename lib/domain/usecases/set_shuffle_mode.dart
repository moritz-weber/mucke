import '../entities/shuffle_mode.dart';
import '../modules/queue_manager.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/persistent_player_state_repository.dart';
import '../repositories/platform_integration_repository.dart';

class SetShuffleMode {
  SetShuffleMode(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
    this._playerStateRepository,
    this._queueManagerModule,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;
  final PersistentStateRepository _playerStateRepository;

  final QueueManagerModule _queueManagerModule;

  Future<void> call(ShuffleMode shuffleMode, {bool updateQueue = true}) async {
    _audioPlayerRepository.setShuffleMode(shuffleMode);
    _playerStateRepository.setShuffleMode(shuffleMode);

    if (updateQueue) {
      final currentIndex = _audioPlayerRepository.currentIndexStream.valueWrapper.value;
      final originalIndex = _queueManagerModule.queue[currentIndex].originalIndex;

      await _queueManagerModule.reshuffleQueue(shuffleMode, currentIndex);
      final queue = _queueManagerModule.queue;

      final songList = queue.map((e) => e.song).toList();
      final splitIndex = shuffleMode == ShuffleMode.none ? originalIndex : 0;
      _audioPlayerRepository.replaceQueueAroundIndex(
        index: currentIndex,
        before: songList.sublist(0, splitIndex),
        after: songList.sublist(splitIndex + 1),
      );

      _platformIntegrationRepository.setQueue(songList);
    }
  }
}
