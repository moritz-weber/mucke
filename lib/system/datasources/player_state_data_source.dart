import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../models/queue_item_model.dart';
import '../models/song_model.dart';

abstract class PlayerStateDataSource {
  Future<void> setQueue(List<QueueItemModel> queue);
  Stream<List<SongModel>> get songQueueStream;
  Stream<List<QueueItemModel>> get queueStream;

  Stream<SongModel> get currentSongStream;
  
  Future<void> setCurrentIndex(int index);
  Stream<int> get currentIndexStream;
  
  Future<void> setShuffleMode(ShuffleMode shuffleMode);
  Stream<ShuffleMode> get shuffleModeStream;
  
  Future<void> setLoopMode(LoopMode loopMode);
  Stream<LoopMode> get loopModeStream;
}
