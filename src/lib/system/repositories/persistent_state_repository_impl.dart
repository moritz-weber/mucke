import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playable.dart';
import '../../domain/entities/queue_item.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/repositories/persistent_state_repository.dart';
import '../datasources/persistent_state_data_source.dart';
import '../models/queue_item_model.dart';

class PersistentStateRepositoryImpl implements PersistentStateRepository {
  PersistentStateRepositoryImpl(this._persistentStateDataSource);

  final PersistentStateDataSource _persistentStateDataSource;

  @override
  Future<int?> get currentIndex => _persistentStateDataSource.currentIndex;

  @override
  Future<LoopMode> get loopMode => _persistentStateDataSource.loopMode;

  @override
  Future<List<QueueItem>> get queueItems => _persistentStateDataSource.queueItems;

  @override
  Future<ShuffleMode> get shuffleMode => _persistentStateDataSource.shuffleMode;

  @override
  void setCurrentIndex(int? index) => _persistentStateDataSource.setCurrentIndex(index);

  @override
  void setLoopMode(LoopMode loopMode) => _persistentStateDataSource.setLoopMode(loopMode);

  @override
  void setQueue(List<QueueItem> queue) {
    _persistentStateDataSource.setQueueItems(queue.map((e) => e as QueueItemModel).toList());
  }

  @override
  void setShuffleMode(ShuffleMode shuffleMode) {
    _persistentStateDataSource.setShuffleMode(shuffleMode);
  }

  @override
  Future<List<QueueItem>> get availableSongs => _persistentStateDataSource.availableSongs;

  @override
  Future<Playable> get playable => _persistentStateDataSource.playable;

  @override
  void setAvailableSongs(List<QueueItem> songs) {
    _persistentStateDataSource.setAvailableSongs(songs.map((e) => e as QueueItemModel).toList());
  }

  @override
  void setPlayable(Playable playable) {
    _persistentStateDataSource.setPlayable(playable);
  }
}
