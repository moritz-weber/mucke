import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:mosh/system/models/song_model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/album_model.dart';
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
  TextColumn get albumArtPath => text().nullable()();
  IntColumn get trackNumber => integer().nullable()();
}

@UseMoor(tables: [Albums, Songs])
class MoorMusicDataSource extends _$MoorMusicDataSource
    implements MusicDataSource {
  MoorMusicDataSource() : super(_openConnection());
  MoorMusicDataSource.withQueryExecutor(QueryExecutor e) : super(e);

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
