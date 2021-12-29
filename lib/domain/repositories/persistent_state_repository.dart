import '../entities/loop_mode.dart';
import '../entities/playable.dart';
import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';

abstract class PersistentStateRepository {
  Future<List<QueueItem>> get queueItems;
  Future<List<QueueItem>> get availableSongs;
  Future<Playable> get playable;
  Future<int> get currentIndex;

  Future<LoopMode> get loopMode;
  Future<ShuffleMode> get shuffleMode;

  void setShuffleMode(ShuffleMode shuffleMode);
  void setLoopMode(LoopMode loopMode);
  void setQueue(List<QueueItem> queue);
  void setAvailableSongs(List<QueueItem> songs);
  void setPlayable(Playable playable);
  void setCurrentIndex(int index);
}
