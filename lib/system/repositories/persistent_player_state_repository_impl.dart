import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/persistent_player_state_repository.dart';
import '../datasources/player_state_data_source.dart';
import '../models/queue_item_model.dart';

class PersistentStateRepositoryImpl implements PersistentStateRepository {
  PersistentStateRepositoryImpl(this._persistentStateDataSource);

  final PersistentStateDataSource _persistentStateDataSource;

  @override
  Stream<int> get currentIndexStream => _persistentStateDataSource.currentIndexStream;

  @override
  Stream<Song> get currentSongStream => _persistentStateDataSource.currentSongStream;

  @override
  Stream<LoopMode> get loopModeStream => _persistentStateDataSource.loopModeStream;

  @override
  Stream<List<Song>> get queueStream => _persistentStateDataSource.songQueueStream;

  @override
  Stream<ShuffleMode> get shuffleModeStream => _persistentStateDataSource.shuffleModeStream;

  @override
  void setCurrentIndex(int index) => _persistentStateDataSource.setCurrentIndex(index);

  @override
  void setLoopMode(LoopMode loopMode) => _persistentStateDataSource.setLoopMode(loopMode);

  @override
  void setQueue(List<QueueItem> queue) {
    _persistentStateDataSource.setQueue(queue.map((e) => e as QueueItemModel).toList());
  }

  @override
  void setShuffleMode(ShuffleMode shuffleMode) {
    _persistentStateDataSource.setShuffleMode(shuffleMode);
  }
}
