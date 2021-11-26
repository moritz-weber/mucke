import 'dart:math';

import '../entities/queue_item.dart';
import '../repositories/music_data_repository.dart';
import 'queue_generator.dart';

class LinearQueueGenerator extends QueueGenerator {
  LinearQueueGenerator(
    List<QueueItem> queueItems,
    bool respectSongLinks,
    MusicDataInfoRepository musicDataRepository,
  ) : super(musicDataRepository, respectSongLinks) {
    _pool = List.from(queueItems);
  }

  late List<QueueItem> _pool;

  @override
  void addQueueItems(List<QueueItem> queueItems) {
    _pool.addAll(queueItems);
    _pool.sort((a, b) => a.originalIndex.compareTo(b.originalIndex));
  }

  // TODO: should this also respect song links?
  @override
  Future<List<QueueItem>> generate(int numberOfSongs) async {
    final max = min(numberOfSongs, _pool.length);

    final result = _pool.sublist(0, max);
    _pool.removeRange(0, max);

    return result;
  }

  @override
  List<QueueItem> get queueItemPool => _pool;

  @override
  List<QueueItem> removeBlocked() {
    final result = <QueueItem>[];

    for (int i = 0; i < _pool.length;) {
      if (_pool[i].song.blocked) {
        result.add(_pool.removeAt(i));
      } else {
        i++;
      }
    }

    return result;
  }

  @override
  void removeQueueItems(List<QueueItem> queueItems) {
    queueItems.forEach(_pool.remove);
  }

  @override
  List<QueueItem> removeSkipped(int threshold) {
    final result = <QueueItem>[];

    for (int i = 0; i < _pool.length;) {
      if (_pool[i].song.skipCount >= threshold) {
        result.add(_pool.removeAt(i));
      } else {
        i++;
      }
    }

    return result;
  }
}
