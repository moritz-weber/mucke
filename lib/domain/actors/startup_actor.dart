import '../repositories/music_data_repository.dart';
import '../repositories/persistent_player_state_repository.dart';
import '../usecases/set_current_song.dart';
import '../usecases/set_loop_mode.dart';
import '../usecases/set_shuffle_mode.dart';

class StartupActor {
  StartupActor(
    this._musicDataInfoRepository,
    this._persistentStateRepository,
    this._setCurrentSong,
    this._setLoopMode,
    this._setShuffleMode,
  );

  final MusicDataInfoRepository _musicDataInfoRepository;
  final PersistentStateRepository _persistentStateRepository;

  final SetCurrentSong _setCurrentSong;
  final SetShuffleMode _setShuffleMode;
  final SetLoopMode _setLoopMode;

  Future<void> init() async {
    final shuffleMode = await _persistentStateRepository.shuffleModeStream.first;
    if (shuffleMode != null) {
      _setShuffleMode(shuffleMode, updateQueue: false);
    }

    final loopMode = await _persistentStateRepository.loopModeStream.first;
    if (loopMode != null) {
      _setLoopMode(loopMode);
    }
  }
}
