import 'package:fimber/fimber.dart';

import '../repositories/audio_player_repository.dart';
import '../repositories/persistent_state_repository.dart';

class PersistenceActor {
  PersistenceActor(
    this._persistentStateRepository,
    this._audioPlayerRepository,
  ) {
    // TODO: queue persistence
    // _audioPlayerRepository.managedQueueInfo.queueItemsStream.listen((queue) {
    //   _log.d('setQueue');
    //   _persistentStateRepository.setQueue(queue);
    // });

    // _audioPlayerRepository.managedQueueInfo.addedSongsStream.listen((songs) {
    //   _log.d('setAddedSongs');
    //   _persistentStateRepository.setAddedSongs(songs);
    // });

    // _audioPlayerRepository.managedQueueInfo.originalSongsStream.listen((songs) {
    //   _log.d('setOriginalSongs');
    //   _persistentStateRepository.setOriginalSongs(songs);
    // });

    // this is tricky, because these actors are instanciated very early
    // and the first currentIndex is null -> ignore this one
    _audioPlayerRepository.currentIndexStream.skip(1).listen((index) {
      _log.d('setCurrentIndex: $index');
      _persistentStateRepository.setCurrentIndex(index);
    });

    _audioPlayerRepository.loopModeStream.skip(1).listen((loopMode) {
      _log.d('setLoopMode: $loopMode');
      _persistentStateRepository.setLoopMode(loopMode);
    });

    _audioPlayerRepository.shuffleModeStream.skip(1).listen((shuffleMode) {
      _log.d('setShuffleMode: $shuffleMode');
      _persistentStateRepository.setShuffleMode(shuffleMode);
    });
  }

  static final _log = FimberLog('PersistenceActor');

  final AudioPlayerRepository _audioPlayerRepository;
  final PersistentStateRepository _persistentStateRepository;

  // TODO: gefällt mir nicht (weil AudioPlayer bspw. auch Infos aus Settings braucht)
  // -> hier müsste noch der skipThreshold dazu
  Future<void> init() async {
    final queueItems = await _persistentStateRepository.queueItems;
    final originalSongs = await _persistentStateRepository.originalSongs;
    final addedSongs = await _persistentStateRepository.addedSongs;
    final index = await _persistentStateRepository.currentIndex;

    _audioPlayerRepository.initQueue(queueItems, originalSongs, addedSongs, index);

    final shuffleMode = await _persistentStateRepository.shuffleMode;
    _audioPlayerRepository.setShuffleMode(shuffleMode, updateQueue: false);

    final loopMode = await _persistentStateRepository.loopMode;
    _audioPlayerRepository.setLoopMode(loopMode);
  }
}
