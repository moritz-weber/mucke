import 'package:logging/logging.dart';

import '../repositories/audio_player_repository.dart';
import '../repositories/persistent_state_repository.dart';

class PersistenceActor {
  PersistenceActor(
    this._persistentStateRepository,
    this._audioPlayerRepository,
  ) {
    // this is tricky, because these actors are instanciated very early
    // and the first currentIndex is null -> ignore this one
    // TODO: double check the skip count here!
    _audioPlayerRepository.managedQueueInfo.queueItemsStream.skip(2).listen((queue) {
      _log.fine('setQueue');
      _persistentStateRepository.setQueue(queue);
    });

    _audioPlayerRepository.managedQueueInfo.availableSongsStream.skip(2).listen((songs) {
      _log.fine('setAvailableSongs');
      _persistentStateRepository.setAvailableSongs(songs);
    });

    _audioPlayerRepository.playableStream.skip(1).listen((playable) {
      _log.fine('setPlayable');
      _persistentStateRepository.setPlayable(playable);
    });

    _audioPlayerRepository.currentIndexStream.skip(1).listen((index) {
      _log.fine('setCurrentIndex: $index');
      _persistentStateRepository.setCurrentIndex(index);
    });

    _audioPlayerRepository.loopModeStream.skip(1).listen((loopMode) {
      _log.fine('setLoopMode: $loopMode');
      _persistentStateRepository.setLoopMode(loopMode);
    });

    _audioPlayerRepository.shuffleModeStream.skip(1).listen((shuffleMode) {
      _log.fine('setShuffleMode: $shuffleMode');
      _persistentStateRepository.setShuffleMode(shuffleMode);
    });
  }

  static final _log = Logger('PersistenceActor');

  final AudioPlayerRepository _audioPlayerRepository;
  final PersistentStateRepository _persistentStateRepository;

  Future<void> init() async {
    _log.fine('init');
    final queueItems = await _persistentStateRepository.queueItems;
    final availableSongs = await _persistentStateRepository.availableSongs;
    final playable = await _persistentStateRepository.playable;
    final index = await _persistentStateRepository.currentIndex;

    final shuffleMode = await _persistentStateRepository.shuffleMode;
    _audioPlayerRepository.setShuffleMode(shuffleMode, updateQueue: false);

    final loopMode = await _persistentStateRepository.loopMode;
    _audioPlayerRepository.setLoopMode(loopMode);

    _audioPlayerRepository.initQueue(queueItems, availableSongs, playable, index);
  }
}
