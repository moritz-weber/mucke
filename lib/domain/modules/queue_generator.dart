import '../../system/models/queue_item_model.dart';
import '../../system/models/song_model.dart';
import '../entities/queue_item.dart';
import '../repositories/music_data_repository.dart';

// TODO: pools etc. should get updated on SongUpdate
abstract class QueueGenerator {
  QueueGenerator(this._musicDataRepository, this.respectSongLinks);

  bool respectSongLinks;

  final MusicDataInfoRepository _musicDataRepository;

  List<QueueItem> get queueItemPool;
  Future<List<QueueItem>> generate(int numberOfSongs);

  List<QueueItem> removeBlocked();
  List<QueueItem> removeSkipped(int threshold);
  void removeQueueItems(List<QueueItem> queueItems);
  void addQueueItems(List<QueueItem> queueItems);

  // TODO: is there a better place for this?
  // TODO: how to set originalIndex if predecessor/successor is in pool?
  Future<List<QueueItem>> getQueueItemWithLinks(QueueItem queueItem) async {
    final List<QueueItem> queueItems = [];

    final predecessors = await _musicDataRepository.getPredecessors(queueItem.song);
    final successors = await _musicDataRepository.getSuccessors(queueItem.song);

    for (final p in predecessors) {
      queueItems.add(QueueItemModel(
        p as SongModel,
        originalIndex: queueItem.originalIndex,
        source: QueueItemSource.predecessor,
      ));
    }

    queueItems.add(queueItem);

    for (final s in successors) {
      queueItems.add(QueueItemModel(
        s as SongModel,
        originalIndex: queueItem.originalIndex,
        source: QueueItemSource.successor,
      ));
    }

    return queueItems;
  }
}
