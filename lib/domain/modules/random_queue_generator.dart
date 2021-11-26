import 'dart:math';

import '../entities/queue_item.dart';
import '../repositories/music_data_repository.dart';
import 'queue_generator.dart';

class RandomQueueGenerator extends QueueGenerator {
  RandomQueueGenerator(
    List<QueueItem> queueItems,
    bool respectSongLinks,
    MusicDataInfoRepository musicDataRepository,
  ) : super(musicDataRepository, respectSongLinks) {
    _pool = List.from(queueItems);
  }

  late List<QueueItem> _pool;
  final Random _rnd = Random();

  @override
  void addQueueItems(List<QueueItem> queueItems) {
    _pool.addAll(queueItems);
  }

  @override
  Future<List<QueueItem>> generate(int numberOfSongs) async {
    final result = <QueueItem>[];

    for (int i = 0; i < numberOfSongs && _pool.isNotEmpty; i++) {
      final index = _rnd.nextInt(_pool.length);

      if (respectSongLinks) {
        final linkedSong = await getQueueItemWithLinks(_pool[index]);
        i += linkedSong.length - 1;
        result.addAll(linkedSong);
        if (linkedSong.length > 1) {
          for (final q in linkedSong) {
            _pool.removeWhere((e) => e.song == q.song);
          }
        } else {
          // this is faster
          _pool.removeAt(index);
        }
      } else {
        result.add(_pool.removeAt(index));
      }
    }

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
