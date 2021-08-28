import 'dart:io';
import 'dart:isolate';

import 'package:moor/ffi.dart';
import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'moor/music_data_dao.dart';
import 'moor/persistent_state_dao.dart';
import 'moor/settings_dao.dart';

part 'moor_database.g.dart';

const String MOOR_ISOLATE = 'MOOR_ISOLATE';

@DataClassName('MoorArtist')
class Artists extends Table {
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {name};
}

@DataClassName('MoorAlbum')
class Albums extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get albumArtPath => text().nullable()();
  IntColumn get year => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MoorSong')
class Songs extends Table {
  TextColumn get title => text()();
  TextColumn get albumTitle => text()();
  IntColumn get albumId => integer()();
  TextColumn get artist => text()();
  TextColumn get path => text()();
  IntColumn get duration => integer()();
  TextColumn get albumArtPath => text().nullable()();
  IntColumn get discNumber => integer()();
  IntColumn get trackNumber => integer()();
  BoolColumn get blocked => boolean().withDefault(const Constant(false))();
  IntColumn get likeCount => integer().withDefault(const Constant(0))();
  IntColumn get skipCount => integer().withDefault(const Constant(0))();
  IntColumn get playCount => integer().withDefault(const Constant(0))();
  BoolColumn get present => boolean().withDefault(const Constant(true))();

  TextColumn get previous => text().withDefault(const Constant(''))();
  TextColumn get next => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {path};
}

@DataClassName('MoorQueueEntry')
class QueueEntries extends Table {
  IntColumn get index => integer()();
  TextColumn get path => text()();
  IntColumn get originalIndex => integer()();
  IntColumn get type => integer()();

  @override
  Set<Column> get primaryKey => {index};
}

@DataClassName('OriginalSongEntry')
class OriginalSongEntries extends Table {
  IntColumn get index => integer()();
  TextColumn get path => text()();

  @override
  Set<Column> get primaryKey => {index};
}

@DataClassName('AddedSongEntry')
class AddedSongEntries extends Table {
  IntColumn get index => integer()();
  TextColumn get path => text()();

  @override
  Set<Column> get primaryKey => {index};
}

class PersistentIndex extends Table {
  IntColumn get index => integer().nullable()();
}

class PersistentShuffleMode extends Table {
  IntColumn get shuffleMode => integer().withDefault(const Constant(0))();
}

class PersistentLoopMode extends Table {
  IntColumn get loopMode => integer().withDefault(const Constant(0))();
}

class LibraryFolders extends Table {
  TextColumn get path => text()();
}

class MoorAlbumOfDay extends Table {
  IntColumn get albumId => integer()();
  IntColumn get milliSecSinceEpoch => integer()();

  @override
  Set<Column> get primaryKey => {albumId};
}

@DataClassName('MoorSmartList')
class SmartLists extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get position => integer()();
  TextColumn get name => text()();
  TextColumn get shuffleMode => text().nullable()();

  // Filter
  BoolColumn get excludeArtists => boolean().withDefault(const Constant(false))();
  IntColumn get minLikeCount => integer().withDefault(const Constant(0))();
  IntColumn get maxLikeCount => integer().withDefault(const Constant(5))();
  IntColumn get minPlayCount => integer().nullable()();
  IntColumn get maxPlayCount => integer().nullable()();
  IntColumn get limit => integer().nullable()();

  // OrderBy
  TextColumn get orderCriteria => text()();
  TextColumn get orderDirections => text()();
}

@DataClassName('MoorSmartListArtist')
class SmartListArtists extends Table {
  IntColumn get smartListId => integer()();
  TextColumn get artistName => text()();
}

@UseMoor(
  tables: [
    Albums,
    Artists,
    LibraryFolders,
    QueueEntries,
    OriginalSongEntries,
    AddedSongEntries,
    PersistentIndex,
    PersistentLoopMode,
    PersistentShuffleMode,
    Songs,
    MoorAlbumOfDay,
    SmartLists,
    SmartListArtists,
  ],
  daos: [
    PersistentStateDao,
    SettingsDao,
    MusicDataDao,
  ],
)
class MoorDatabase extends _$MoorDatabase {
  /// Use MoorMusicDataSource in main isolate only.
  MoorDatabase() : super(_openConnection());

  /// Used for testing with in-memory database.
  MoorDatabase.withQueryExecutor(QueryExecutor e) : super(e);

  /// Used to connect to a database on another isolate.
  MoorDatabase.connect(DatabaseConnection connection) : super.connect(connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          if (details.wasCreated) {
            await into(persistentIndex).insert(const PersistentIndexCompanion(index: Value(0)));
            await into(persistentLoopMode)
                .insert(const PersistentLoopModeCompanion(loopMode: Value(0)));
            await into(persistentShuffleMode)
                .insert(const PersistentShuffleModeCompanion(shuffleMode: Value(0)));
          }
        },
      );
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

Future<MoorIsolate> createMoorIsolate() async {
  // this method is called from the main isolate. Since we can't use
  // getApplicationDocumentsDirectory on a background isolate, we calculate
  // the database path in the foreground isolate and then inform the
  // background isolate about the path.
  final dir = await getApplicationDocumentsDirectory();
  final path = p.join(dir.path, 'db.sqlite');
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, path),
  );

  // _startBackground will send the MoorIsolate to this ReceivePort
  return await receivePort.first as MoorIsolate;
}

void _startBackground(_IsolateStartRequest request) {
  // this is the entry point from the background isolate! Let's create
  // the database from the path we received
  final executor = VmDatabase(File(request.targetPath));
  // we're using MoorIsolate.inCurrent here as this method already runs on a
  // background isolate. If we used MoorIsolate.spawn, a third isolate would be
  // started which is not what we want!
  final moorIsolate = MoorIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );
  // inform the starting isolate about this, so that it can call .connect()
  request.sendMoorIsolate.send(moorIsolate);
}

// used to bundle the SendPort and the target path, since isolate entry point
// functions can only take one parameter.
class _IsolateStartRequest {
  _IsolateStartRequest(this.sendMoorIsolate, this.targetPath);

  final SendPort sendMoorIsolate;
  final String targetPath;
}
