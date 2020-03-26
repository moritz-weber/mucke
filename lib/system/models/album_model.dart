import 'package:meta/meta.dart';

import '../../domain/entities/album.dart';
import '../datasources/moor_music_data_source.dart';

class AlbumModel extends Album {
  AlbumModel({
    this.id,
    @required String title,
    @required String artist,
    String albumArtPath,
    int year,
  }) : super(
          title: title,
          artist: artist,
          albumArtPath: albumArtPath,
          year: year,
        );

  factory AlbumModel.fromMoor(MoorAlbum moorAlbum) => AlbumModel(
        title: moorAlbum.title,
        artist: moorAlbum.artist,
        albumArtPath: moorAlbum.albumArtPath,
        year: moorAlbum.year,
      );

  final int id;

  MoorAlbum toMoor() => MoorAlbum(
        title: title,
        artist: artist,
        albumArtPath: albumArtPath,
        year: year,
      );
}
