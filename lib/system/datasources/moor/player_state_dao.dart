import 'package:moor/moor.dart';

import '../../../domain/entities/loop_mode.dart';
import '../../../domain/entities/shuffle_mode.dart';
import '../../models/loop_mode_model.dart';
import '../../models/queue_item_model.dart';
import '../../models/shuffle_mode_model.dart';
import '../../models/song_model.dart';
import '../moor_music_data_source.dart';
import '../player_state_data_source.dart';

part 'player_state_dao.g.dart';

@UseDao(tables: [Songs, QueueEntries, PlayerState])
class PlayerStateDao extends DatabaseAccessor<MoorMusicDataSource> with _$PlayerStateDaoMixin implements PlayerStateDataSource  {
  PlayerStateDao(MoorMusicDataSource db) : super(db);

  @override
  Stream<List<SongModel>> get songQueueStream {
    final query = (select(queueEntries)..orderBy([(t) => OrderingTerm(expression: t.index)]))
        .join([innerJoin(songs, songs.path.equalsExp(queueEntries.path))]);

    return query.watch().map((rows) {
      return rows.map((row) => SongModel.fromMoorSong(row.readTable(songs))).toList();
    });
  }

  @override
  Stream<List<QueueItemModel>> get queueStream {
    final query = (select(queueEntries)..orderBy([(t) => OrderingTerm(expression: t.index)]))
        .join([innerJoin(songs, songs.path.equalsExp(queueEntries.path))]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return QueueItemModel(
          SongModel.fromMoorSong(row.readTable(songs)),
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
    return select(playerState).watchSingle().map((event) => event.index);
  }

  @override
  Future<void> setCurrentIndex(int index) async {
    final currentState = await select(playerState).getSingle();
    if (currentState != null) {
      update(playerState).write(PlayerStateCompanion(index: Value(index)));
    } else {
      into(playerState).insert(PlayerStateCompanion(index: Value(index)));
    }
  }

  @override
  Stream<LoopMode> get loopModeStream {
    return select(playerState).watchSingle().map((event) => event.loopMode.toLoopMode());
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    final currentState = await select(playerState).getSingle();
    if (currentState != null) {
      update(playerState).write(PlayerStateCompanion(loopMode: Value(loopMode.toInt())));
    } else {
      into(playerState).insert(PlayerStateCompanion(loopMode: Value(loopMode.toInt())));
    }
  }

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    final currentState = await select(playerState).getSingle();
    if (currentState != null) {
      update(playerState).write(PlayerStateCompanion(shuffleMode: Value(shuffleMode.toInt())));
    } else {
      into(playerState).insert(PlayerStateCompanion(shuffleMode: Value(shuffleMode.toInt())));
    }
  }

  @override
  Stream<ShuffleMode> get shuffleModeStream {
    return select(playerState).watchSingle().map((event) => event.shuffleMode.toShuffleMode());
  }
}