import 'dart:math';

import 'package:flutter_fimber/flutter_fimber.dart';

import '../../constants.dart';
import '../entities/queue_item.dart';
import '../repositories/music_data_repository.dart';
import 'queue_generator.dart';

class WeightedRandomQueueGenerator extends QueueGenerator {
  WeightedRandomQueueGenerator(
    List<QueueItem> queueItems,
    bool respectSongLinks,
    MusicDataInfoRepository musicDataRepository,
  ) : super(musicDataRepository, respectSongLinks) {
    _log.i('Start bucket list with ${queueItems.length} items');
    _buckets = List.generate(MAX_LIKE_COUNT + 1, (index) => []);

    for (final qi in queueItems) {
      if (!qi.song.blocked && qi.song.skipCount < 3) {
        _buckets[qi.song.likeCount].add(qi);
      }
    }

    _buckets[0][0].originalIndex = 123456;

    // 0.7ms dauert das mit 3000 Liedern...
    // TODO: dieses ganze remove und so, kann man also sparen und einfach die Buckets jedes Mal erzeugen
    // auch mit filtern gar kein Problem
    _log.i('Finished bucket list');
  }

  static final _log = FimberLog('QueueGenerator');

  late final List<List<QueueItem>> _buckets;
  final Random _rnd = Random();

  @override
  List<QueueItem> get queueItemPool => _buckets.expand((e) => e).toList();

  @override
  void addQueueItems(List<QueueItem> queueItems) {
    print(queueItems.length);
  }

  @override
  Future<List<QueueItem>> generate(int numberOfSongs) async {
    final List<QueueItem> result = [];

    for (int i = 0; i < numberOfSongs && queueItemPool.isNotEmpty; i++) {
      final bucketIndex = _getBucketIndex();
      final bucket = _buckets[bucketIndex];

      final index = _rnd.nextInt(bucket.length);

      if (respectSongLinks) {
        final linkedSong = await getQueueItemWithLinks(bucket[index]);
        result.addAll(linkedSong);
        i += linkedSong.length - 1;

        if (linkedSong.length > 1) {
          for (final q in linkedSong) {
            _buckets[q.song.likeCount].removeWhere((e) => e.song == q.song);
          }
        } else {
          // this is faster
          bucket.removeAt(index);
        }
      } else {
        result.add(bucket.removeAt(index));
      }
    }

    return result;
  }

  @override
  List<QueueItem> removeBlocked() {
    final result = <QueueItem>[];

    for (final bucket in _buckets) {
      for (int i = 0; i < bucket.length;) {
        if (bucket[i].song.blocked) {
          result.add(bucket.removeAt(i));
        } else {
          i++;
        }
      }
    }

    return result;
  }

  @override
  List<QueueItem> removeSkipped(int threshold) {
    final result = <QueueItem>[];

    for (final bucket in _buckets) {
      for (int i = 0; i < bucket.length;) {
        if (bucket[i].song.skipCount >= threshold) {
          result.add(bucket.removeAt(i));
        } else {
          i++;
        }
      }
    }

    return result;
  }

  @override
  void removeQueueItems(List<QueueItem> queueItems) {
    for (final q in queueItems) {
      _buckets[q.song.likeCount].remove(q);
    }
  }

  int _getBucketIndex() {
    final List<int> tickets = [];

    tickets.add(_buckets[0].length);
    tickets.add(_buckets[1].length * 2);
    tickets.add(_buckets[2].length * 4);
    tickets.add(_buckets[3].length * 8);

    final int sum = tickets.fold(0, (prev, amount) => prev + amount);

    int rndNumber = _rnd.nextInt(sum);
    for (int i = 0; i < tickets.length; i++) {
      if (rndNumber < tickets[i]) {
        return i;
      } else {
        rndNumber -= tickets[i];
      }
    }
    throw Error();
  }
}
