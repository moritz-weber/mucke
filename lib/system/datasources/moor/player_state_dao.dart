import 'package:moor/moor.dart';

import '../../../domain/entities/loop_mode.dart';
import '../../../domain/entities/shuffle_mode.dart';
import '../../models/loop_mode_model.dart';
import '../../models/queue_item_model.dart';
import '../../models/shuffle_mode_model.dart';
import '../../models/song_model.dart';
import '../moor_database.dart';
import '../player_state_data_source.dart';

part 'player_state_dao.g.dart';

@UseDao(tables: [Songs, QueueEntries, PersistentIndex, PersistentShuffleMode, PersistentLoopMode])
class PlayerStateDao extends DatabaseAccessor<MoorDatabase>
    with _$PlayerStateDaoMixin
    implements PlayerStateDataSource {
  PlayerStateDao(MoorDatabase db) : super(db);

  @override
  Stream<List<SongModel>> get songQueueStream {
    final query = (select(queueEntries)..orderBy([(t) => OrderingTerm(expression: t.index)]))
        .join([innerJoin(songs, songs.path.equalsExp(queueEntries.path))]);

    return query.watch().map((rows) {
      return rows.map((row) => SongModel.fromMoor(row.readTable(songs))).toList();
    });
  }

  @override
  Stream<List<QueueItemModel>> get queueStream {
    final query = (select(queueEntries)..orderBy([(t) => OrderingTerm(expression: t.index)]))
        .join([innerJoin(songs, songs.path.equalsExp(queueEntries.path))]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return QueueItemModel(
          SongModel.fromMoor(row.readTable(songs)),
          originalIndex: row.readTable(queueEntries).originalIndex,
          type: row.readTable(queueEntries).type.toQueueItemType(),
        );
      }).toList();
    });
  }

  @override
  Future<void> setQueue(List<QueueItemModel> queue) async {
    final _queueEntries = <Insertable<MoorQueueEntry>>[];

    for (var i = 0; i < queue.length; i++) {
      _queueEntries.add(QueueEntriesCompanion(
        index: Value(i),
        path: Value(queue[i].song.path),
        originalIndex: Value(queue[i].originalIndex),
        type: Value(queue[i].type.toInt()),
      ));
    }

    await delete(queueEntries).go();
    await batch((batch) {
      batch.insertAll(queueEntries, _queueEntries);
    });
  }

  @override
  Stream<int> get currentIndexStream {
    return select(persistentIndex).watchSingle().map((event) => event?.index);
  }

  @override
  Future<void> setCurrentIndex(int index) async {
    update(persistentIndex).write(PersistentIndexCompanion(index: Value(index)));
  }

  @override
  Stream<LoopMode> get loopModeStream {
    return select(persistentLoopMode).watchSingle().map((event) => event?.loopMode?.toLoopMode());
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    update(persistentLoopMode).write(
      PersistentLoopModeCompanion(loopMode: Value(loopMode.toInt())),
    );
  }

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    update(persistentShuffleMode).write(
      PersistentShuffleModeCompanion(shuffleMode: Value(shuffleMode.toInt())),
    );
  }

  @override
  Stream<ShuffleMode> get shuffleModeStream {
    return select(persistentShuffleMode)
        .watchSingle()
        .map((event) => event?.shuffleMode?.toShuffleMode());
  }
}
