import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/persistent_player_state_repository.dart';
import '../datasources/player_state_data_source.dart';

class PlayerStateRepositoryImpl implements PlayerStateRepository {
  PlayerStateRepositoryImpl(this._playerStateDataSource);

  final PlayerStateDataSource _playerStateDataSource;

  @override
  Stream<int> get currentIndexStream => _playerStateDataSource.currentIndexStream;

  @override
  Stream<Song> get currentSongStream => _playerStateDataSource.currentSongStream;

  @override
  Stream<LoopMode> get loopModeStream => _playerStateDataSource.loopModeStream;

  @override
  Stream<List<Song>> get queueStream => _playerStateDataSource.songQueueStream;

  @override
  Stream<ShuffleMode> get shuffleModeStream => _playerStateDataSource.shuffleModeStream;

  @override
  void setCurrentIndex(int index) {
    // TODO: implement setCurrentIndex
  }

  @override
  void setLoopMode(LoopMode loopMode) {
    // TODO: implement setLoopMode
  }

  @override
  void setQueue(List<QueueItem> queue) {
    // TODO: implement setQueue
  }

  @override
  void setShuffleMode(ShuffleMode shuffleMode) {
    // TODO: implement setShuffleMode
  }
}
