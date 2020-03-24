import 'package:meta/meta.dart';

import '../../domain/entities/album.dart';
import '../datasources/moor_music_data_source.dart';

class AlbumModel extends Album {
  final int id;

  AlbumModel({this.id, @required title, @required artist, albumArtPath, year})
      : super(
            title: title,
            artist: artist,
            albumArtPath: albumArtPath,
            year: year);

  factory AlbumModel.fromMoor(MoorAlbum moorAlbum) => AlbumModel(
      title: moorAlbum.title,
      artist: moorAlbum.artist,
      albumArtPath: moorAlbum.albumArtPath,
      year: moorAlbum.year);

  MoorAlbum toMoor() => MoorAlbum(
      title: title,
      artist: artist,
      albumArtPath: albumArtPath,
      year: year);
}
