import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/playable.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../models/queue_item_model.dart';

abstract class PersistentStateDataSource {
  Future<bool> get isInitialized;
  Future<void> setInitialized();

  Future<void> setQueueItems(List<QueueItemModel> queueItems);
  Future<List<QueueItemModel>> get queueItems;

  Future<void> setAvailableSongs(List<QueueItemModel> songs);
  Future<List<QueueItemModel>> get availableSongs;

  Future<void> setCurrentIndex(int? index);
  Future<int?> get currentIndex;

  Future<void> setPlayable(Playable playable);
  Future<Playable> get playable;

  Future<void> setShuffleMode(ShuffleMode shuffleMode);
  Future<ShuffleMode> get shuffleMode;

  Future<void> setLoopMode(LoopMode loopMode);
  Future<LoopMode> get loopMode;
}
