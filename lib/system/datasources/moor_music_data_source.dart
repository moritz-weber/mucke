import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/album_model.dart';
import 'music_data_source_contract.dart';

part 'moor_music_data_source.g.dart';

@DataClassName("MoorAlbum")
class Albums extends Table {
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get albumArtPath => text().nullable()();
  IntColumn get year => integer().nullable()();

  @override
  Set<Column> get primaryKey => {title, artist};
}

@UseMoor(tables: [Albums])
class MoorMusicDataSource extends _$MoorMusicDataSource
    implements MusicDataSource {
  MoorMusicDataSource() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Future<AlbumModel> getAlbum(String title, String artist) async {
  //   return (select(albums)..where((t) => t.title.equals(title)))
  //       .getSingle()
  //       .then((moorAlbum) => AlbumModel.fromMoor(moorAlbum));
  // }

  @override
  Future<List<AlbumModel>> getAlbums() async {
    return select(albums).get().then((moorAlbumList) => moorAlbumList
        .map((moorAlbum) => AlbumModel.fromMoor(moorAlbum))
        .toList());
  }

  @override
  Future<void> insertAlbum(AlbumModel albumModel) {
    // TODO: implement insertAlbum
    return null;
  }

  @override
  Future<bool> albumExists(AlbumModel albumModel) {
    // TODO: implement albumExists
    return null;
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}
