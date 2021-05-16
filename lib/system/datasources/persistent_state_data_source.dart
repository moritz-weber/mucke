import '../../domain/entities/loop_mode.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../models/queue_item_model.dart';
import '../models/song_model.dart';

abstract class PersistentStateDataSource {
  Future<void> setQueueItems(List<QueueItemModel> queueItems);
  Future<List<QueueItemModel>> get queueItems;

  Future<void> setOriginalSongs(List<SongModel> songs);
  Future<List<SongModel>> get originalSongs;

  Future<void> setAddedSongs(List<SongModel> songs);
  Future<List<SongModel>> get addedSongs;

  Future<void> setCurrentIndex(int index);
  Future<int> get currentIndex;

  Future<void> setShuffleMode(ShuffleMode shuffleMode);
  Future<ShuffleMode> get shuffleMode;

  Future<void> setLoopMode(LoopMode loopMode);
  Future<LoopMode> get loopMode;
}
