import 'dart:io';
import 'dart:isolate';

import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/album_model.dart';
import '../models/song_model.dart';
import 'music_data_source_contract.dart';

part 'moor_music_data_source.g.dart';

@DataClassName('MoorAlbum')
class Albums extends Table {
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get albumArtPath => text().nullable()();
  IntColumn get year => integer().nullable()();

  @override
  Set<Column> get primaryKey => {title, artist};
}

@DataClassName('MoorSong')
class Songs extends Table {
  TextColumn get title => text()();
  TextColumn get album => text()();
  TextColumn get artist => text()();
  TextColumn get path => text()();
  IntColumn get duration => integer().nullable()();
  TextColumn get albumArtPath => text().nullable()();
  IntColumn get trackNumber => integer().nullable()();
}

@UseMoor(tables: [Albums, Songs])
class MoorMusicDataSource extends _$MoorMusicDataSource
    implements MusicDataSource {
  /// Use MoorMusicDataSource in main isolate only.
  MoorMusicDataSource() : super(_openConnection());
  /// Used for testing with in-memory database.
  MoorMusicDataSource.withQueryExecutor(QueryExecutor e) : super(e);
  /// Used to connect to a database on another isolate.
  MoorMusicDataSource.connect(DatabaseConnection connection) : super.connect(connection);

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
  Future<void> insertAlbum(AlbumModel albumModel) async {
    await into(albums).insert(albumModel.toAlbumsCompanion());
    return;
  }

  @override
  Future<bool> albumExists(AlbumModel albumModel) async {
    final List<AlbumModel> albumList = await getAlbums();
    return albumList.contains(albumModel);
  }

  @override
  Future<List<SongModel>> getSongs() {
    return select(songs).get().then((moorSongList) => moorSongList
        .map((moorSong) => SongModel.fromMoorSong(moorSong))
        .toList());
  }

    @override
  Future<List<SongModel>> getSongsFromAlbum(AlbumModel album) {
    return (select(songs)..where((tbl) => tbl.album.equals(album.title))).get().then((moorSongList) => moorSongList
        .map((moorSong) => SongModel.fromMoorSong(moorSong))
        .toList());
  }

  @override
  Future<void> insertSong(SongModel songModel) async {
    await into(songs).insert(songModel.toSongsCompanion());
    return;
  }

  @override
  Future<bool> songExists(SongModel songModel) async {
    final List<SongModel> songList = await getSongs();
    return songList.contains(songModel);
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
