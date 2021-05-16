import 'package:moor/moor.dart';

import '../../../domain/entities/loop_mode.dart';
import '../../../domain/entities/shuffle_mode.dart';
import '../../models/loop_mode_model.dart';
import '../../models/queue_item_model.dart';
import '../../models/shuffle_mode_model.dart';
import '../../models/song_model.dart';
import '../moor_database.dart';
import '../persistent_state_data_source.dart';

part 'persistent_state_dao.g.dart';

@UseDao(tables: [
  Songs,
  QueueEntries,
  OriginalSongEntries,
  AddedSongEntries,
  PersistentIndex,
  PersistentShuffleMode,
  PersistentLoopMode
])
class PersistentStateDao extends DatabaseAccessor<MoorDatabase>
    with _$PersistentStateDaoMixin
    implements PersistentStateDataSource {
  PersistentStateDao(MoorDatabase db) : super(db);

  @override
  Future<List<QueueItemModel>> get queueItems {
    final query = (select(queueEntries)..orderBy([(t) => OrderingTerm(expression: t.index)]))
        .join([innerJoin(songs, songs.path.equalsExp(queueEntries.path))]);

    return query.get().then((rows) => rows.map((row) {
          return QueueItemModel(
            SongModel.fromMoor(row.readTable(songs)),
            originalIndex: row.readTable(queueEntries).originalIndex,
            type: row.readTable(queueEntries).type.toQueueItemType(),
          );
        }).toList());
  }

  @override
  Future<void> setQueueItems(List<QueueItemModel> queue) async {
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
  Future<List<SongModel>> get addedSongs {
    final query = (select(addedSongEntries)..orderBy([(t) => OrderingTerm(expression: t.index)]))
        .join([innerJoin(songs, songs.path.equalsExp(addedSongEntries.path))]);

    return query.get().then((rows) => rows.map((row) {
          return SongModel.fromMoor(row.readTable(songs));
        }).toList());
  }

  @override
  Future<List<SongModel>> get originalSongs {
    final query = (select(originalSongEntries)..orderBy([(t) => OrderingTerm(expression: t.index)]))
        .join([innerJoin(songs, songs.path.equalsExp(originalSongEntries.path))]);

    return query.get().then((rows) => rows.map((row) {
          return SongModel.fromMoor(row.readTable(songs));
        }).toList());
  }

  @override
  Future<void> setAddedSongs(List<SongModel> songs) async {
    final _songEntries = <Insertable<AddedSongEntry>>[];

    for (var i = 0; i < songs.length; i++) {
      _songEntries.add(AddedSongEntriesCompanion(
        index: Value(i),
        path: Value(songs[i].path),
      ));
    }

    await delete(addedSongEntries).go();
    await batch((batch) {
      batch.insertAll(addedSongEntries, _songEntries);
    });
  }

  @override
  Future<void> setOriginalSongs(List<SongModel> songs) async {
    final _songEntries = <Insertable<OriginalSongEntry>>[];

    for (var i = 0; i < songs.length; i++) {
      _songEntries.add(OriginalSongEntriesCompanion(
        index: Value(i),
        path: Value(songs[i].path),
      ));
    }

    await delete(originalSongEntries).go();
    await batch((batch) {
      batch.insertAll(originalSongEntries, _songEntries);
    });
  }

  @override
  Future<int> get currentIndex async {
    final res = await select(persistentIndex).get();
    return select(persistentIndex).getSingle().then((event) => event?.index);
  }

  @override
  Future<void> setCurrentIndex(int index) async {
    await delete(persistentIndex).go();
    into(persistentIndex).insert(PersistentIndexCompanion(index: Value(index)));
  }

  @override
  Future<LoopMode> get loopMode {
    return select(persistentLoopMode).getSingle().then((event) => event?.loopMode?.toLoopMode());
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
  Future<ShuffleMode> get shuffleMode {
    return select(persistentShuffleMode).getSingle().then(
          (event) => event?.shuffleMode?.toShuffleMode(),
        );
  }
}
