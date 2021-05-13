import '../entities/loop_mode.dart';
import '../entities/queue_item.dart';
import '../entities/shuffle_mode.dart';
import '../entities/song.dart';

abstract class PersistentStateRepository {
  Stream<List<Song>> get queueStream;
  Stream<int> get currentIndexStream;
  Stream<Song> get currentSongStream;
  Stream<LoopMode> get loopModeStream;
  Stream<ShuffleMode> get shuffleModeStream;

  void setShuffleMode(ShuffleMode shuffleMode);
  void setLoopMode(LoopMode loopMode);
  void setQueue(List<QueueItem> queue);
  void setCurrentIndex(int index);
}
