import 'package:fimber/fimber.dart';

import '../repositories/audio_player_repository.dart';
import '../repositories/persistent_state_repository.dart';
import '../usecases/init_queue.dart';
import '../usecases/set_loop_mode.dart';
import '../usecases/set_shuffle_mode.dart';

class PersistenceActor {
  PersistenceActor(
    this._persistentStateRepository,
    this._audioPlayerInfoRepository,
    this._initQueue,
    this._setShuffleMode,
    this._setLoopMode,
  ) {
    _audioPlayerInfoRepository.managedQueueInfo.queueItemsStream.listen((queue) {
      _log.d('setQueue');
      _persistentStateRepository.setQueue(queue);
    });

    _audioPlayerInfoRepository.managedQueueInfo.addedSongsStream.listen((songs) {
      _log.d('setAddedSongs');
      _persistentStateRepository.setAddedSongs(songs);
    });

    _audioPlayerInfoRepository.managedQueueInfo.originalSongsStream.listen((songs) {
      _log.d('setOriginalSongs');
      _persistentStateRepository.setOriginalSongs(songs);
    });

    // this is tricky, because these actors are instanciated very early
    // and the first currentIndex is null -> ignore this one
    _audioPlayerInfoRepository.currentIndexStream.skip(1).listen((index) {
      _log.d('setCurrentIndex: $index');
      _persistentStateRepository.setCurrentIndex(index);
    });

    _audioPlayerInfoRepository.loopModeStream.skip(1).listen((loopMode) {
      _log.d('setLoopMode: $loopMode');
      _persistentStateRepository.setLoopMode(loopMode);
    });

    _audioPlayerInfoRepository.shuffleModeStream.skip(1).listen((shuffleMode) {
      _log.d('setShuffleMode: $shuffleMode');
      _persistentStateRepository.setShuffleMode(shuffleMode);
    });
  }

  static final _log = FimberLog('PersistenceActor');

  final AudioPlayerInfoRepository _audioPlayerInfoRepository;
  final PersistentStateRepository _persistentStateRepository;

  final InitQueue _initQueue;
  final SetShuffleMode _setShuffleMode;
  final SetLoopMode _setLoopMode;

  Future<void> init() async {
    final shuffleMode = await _persistentStateRepository.shuffleMode;
    if (shuffleMode != null) {
      _setShuffleMode(shuffleMode, updateQueue: false);
    }

    final loopMode = await _persistentStateRepository.loopMode;
    if (loopMode != null) {
      _setLoopMode(loopMode);
    }

    final queueItems = await _persistentStateRepository.queueItems;
    final originalSongs = await _persistentStateRepository.originalSongs;
    final addedSongs = await _persistentStateRepository.addedSongs;
    final index = await _persistentStateRepository.currentIndex;

    if (queueItems != null && index != null) {
      _initQueue(queueItems, originalSongs, addedSongs, index);
    }
  }
}
