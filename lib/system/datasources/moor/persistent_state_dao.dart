import 'package:moor/moor.dart';

import '../../../constants.dart';
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
  KeyValueEntries,
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
            source: row.readTable(queueEntries).type.toQueueItemType(),
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
        type: Value(queue[i].source.toInt()),
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
    return (select(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_INDEX)))
        .getSingle()
        .then((event) => int.parse(event.value));
  }

  @override
  Future<void> setCurrentIndex(int index) async {
    (update(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_INDEX)))
        .write(KeyValueEntriesCompanion(value: Value(index.toString())));
  }

  @override
  Future<LoopMode> get loopMode async {
    return (select(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_LOOPMODE)))
        .getSingle()
        .then((event) => int.parse(event.value).toLoopMode());
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    (update(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_LOOPMODE)))
        .write(KeyValueEntriesCompanion(value: Value(loopMode.toInt().toString())));
  }

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    (update(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_SHUFFLEMODE)))
        .write(KeyValueEntriesCompanion(value: Value(shuffleMode.toInt().toString())));
  }

  @override
  Future<ShuffleMode> get shuffleMode {
    return (select(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_SHUFFLEMODE)))
        .getSingle()
        .then((event) => int.parse(event.value).toShuffleMode());
  }

  @override
  Future<bool> get excludeBlocked {
    return (select(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_EXCLUDE_BLOCKED)))
        .getSingle()
        .then((event) => event.value == 'true');
  }

  @override
  Future<bool> get excludeSkipped {
    return (select(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_EXCLUDE_SKIPPED)))
        .getSingle()
        .then((event) => event.value == 'true');
  }

  @override
  Future<bool> get respectSongLinks {
    return (select(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_RESPECT_SONG_LINKS)))
        .getSingle()
        .then((event) => event.value == 'true');
  }

  @override
  Future<void> setExcludeBlocked(bool active) async {
    (update(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_EXCLUDE_BLOCKED)))
        .write(KeyValueEntriesCompanion(value: Value(active.toString())));
  }

  @override
  Future<void> setExcludeSkipped(bool active) async {
    (update(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_EXCLUDE_SKIPPED)))
        .write(KeyValueEntriesCompanion(value: Value(active.toString())));
  }

  @override
  Future<void> setRespectSongLinks(bool active) async {
    (update(keyValueEntries)..where((tbl) => tbl.key.equals(PERSISTENT_RESPECT_SONG_LINKS)))
        .write(KeyValueEntriesCompanion(value: Value(active.toString())));
  }
}
