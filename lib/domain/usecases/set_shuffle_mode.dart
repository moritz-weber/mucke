import 'package:mucke/domain/entities/queue_item.dart';

import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../modules/queue_generator.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/persistent_player_state_repository.dart';
import '../repositories/platform_integration_repository.dart';

class SetShuffleMode {
  SetShuffleMode(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
    this._playerStateRepository,
    this._queueGenerationModule,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;
  final PlayerStateRepository _playerStateRepository;

  final QueueGenerationModule _queueGenerationModule;

  Future<void> call(ShuffleMode shuffleMode) async {
    // _audioPlayerRepository.playSong(songs[initialIndex]);

    _audioPlayerRepository.setShuffleMode(shuffleMode);

    final queue = _audioPlayerRepository.queueStream.value;
    final currentIndex = _audioPlayerRepository.currentIndexStream.value;

    final QueueItem currentQueueItem = queue[currentIndex];
    final int index = currentQueueItem.originalIndex;

    // WAS LETZTE GEDANKE?
    // _inputQueue ist die originale Song Liste aus playSongs o.ä. BEVOR der QueueGenerator drüber läuft

    // _queue = await _queueGenerator.generateQueue(shuffleMode, _inputQueue, index);
    // // TODO: maybe refactor _queue to a subject and listen for changes
    // final songModelQueue = _queue.map((e) => e.song).toList();
    // _queueSubject.add(_queue);

    // final newQueue = _songModelsToAudioSource(songModelQueue);
    // _updateQueue(newQueue, currentQueueItem);

    // final queueItems = await _queueGenerationModule.generateQueue(
    //   shuffleMode,
    //   songs,
    //   initialIndex,
    // );

    // final songList = queueItems.map((e) => e.song).toList();

    // await _audioPlayerRepository.loadQueue(
    //   initialIndex: initialIndex,
    //   queue: songList,
    // );
    // _audioPlayerRepository.play();

    // _platformIntegrationRepository.setCurrentSong(songs[initialIndex]);
    // // _platformIntegrationRepository.play();
    // _platformIntegrationRepository.setQueue(songList);
  }
}
