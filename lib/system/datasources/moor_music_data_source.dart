import 'dart:io';
import 'dart:isolate';

import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/album_model.dart';
import '../models/artist_model.dart';
import '../models/song_model.dart';
import 'music_data_source_contract.dart';

part 'moor_music_data_source.g.dart';

const String MOOR_ISOLATE = 'MOOR_ISOLATE';

@DataClassName('MoorArtist')
class Artists extends Table {
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {name};
}

@DataClassName('MoorAlbum')
class Albums extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get albumArtPath => text().nullable()();
  IntColumn get year => integer().nullable()();
}

@DataClassName('MoorSong')
class Songs extends Table {
  TextColumn get title => text()();
  TextColumn get albumTitle => text()();
  IntColumn get albumId => integer()();
  TextColumn get artist => text()();
  TextColumn get path => text()();
  IntColumn get duration => integer().nullable()();
  TextColumn get albumArtPath => text().nullable()();
  IntColumn get discNumber => integer().nullable()();
  IntColumn get trackNumber => integer().nullable()();
  BoolColumn get blocked => boolean().withDefault(const Constant(false))();
  BoolColumn get present => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {path};
}

@UseMoor(tables: [Artists, Albums, Songs])
class MoorMusicDataSource extends _$MoorMusicDataSource
    implements MusicDataSource {
  /// Use MoorMusicDataSource in main isolate only.
  MoorMusicDataSource() : super(_openConnection());

  /// Used for testing with in-memory database.
  MoorMusicDataSource.withQueryExecutor(QueryExecutor e) : super(e);

  /// Used to connect to a database on another isolate.
  MoorMusicDataSource.connect(DatabaseConnection connection)
      : super.connect(connection);

  @override
  int get schemaVersion => 1;

  @override
  Future<List<AlbumModel>> getAlbums() async {
    return select(albums).get().then((moorAlbumList) => moorAlbumList
        .map((moorAlbum) => AlbumModel.fromMoorAlbum(moorAlbum))
        .toList());
  }

  // TODO: insert can throw exception -> implications?
  @override
  Future<int> insertAlbum(AlbumModel albumModel) async {
    return await into(albums).insert(albumModel.toAlbumsCompanion());
  }

  @override
  Future<List<SongModel>> getSongs() {
    return select(songs).get().then((moorSongList) => moorSongList
        .map((moorSong) => SongModel.fromMoorSong(moorSong))
        .toList());
  }

  @override
  Future<List<SongModel>> getSongsFromAlbum(AlbumModel album) {
    return (select(songs)
          ..where((tbl) => tbl.albumTitle.equals(album.title))
          ..orderBy([
            (t) => OrderingTerm(expression: t.discNumber),
            (t) => OrderingTerm(expression: t.trackNumber)
          ]))
        .get()
        .then((moorSongList) => moorSongList
            .map((moorSong) => SongModel.fromMoorSong(moorSong))
            .toList());
  }

  @override
  Future<void> insertSong(SongModel songModel) async {
    await into(songs).insert(songModel.toSongsCompanion());
  }

  @override
  Future<SongModel> getSongByPath(String path) async {
    return (select(songs)..where((t) => t.path.equals(path))).getSingle().then(
      (moorSong) {
        if (moorSong == null) {
          return null;
        }
        return SongModel.fromMoorSong(moorSong);
      },
    );
  }

  @override
  Future<void> deleteAllArtists() async {
    delete(artists).go();
  }

  @override
  Future<int> insertArtist(ArtistModel artistModel) async {
    return into(artists).insert(artistModel.toArtistsCompanion());
  }

  @override
  Future<void> deleteAllAlbums() async {
    delete(albums).go();
  }

  @override
  Future<void> deleteAllSongs() async {
    delete(songs).go();
  }

  @override
  Future<List<ArtistModel>> getArtists() {
    return select(artists).get().then((moorArtistList) => moorArtistList
        .map((moorArtist) => ArtistModel.fromMoorArtist(moorArtist))
        .toList());
  }

  @override
  Future<void> insertSongs(List<SongModel> songModels) async {
    await update(songs).write(const SongsCompanion(present: Value(false)));

    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        songs,
        songModels.map((e) => e.toMoorInsert()).toList(),
      );
    });

    await (delete(songs)..where((tbl) => tbl.present.equals(false))).go();
  }

  @override
  Future<void> setSongBlocked(SongModel song, bool blocked) async {
    await (update(songs)..where((tbl) => tbl.path.equals(song.path)))
        .write(SongsCompanion(blocked: Value(blocked)));
  }
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
