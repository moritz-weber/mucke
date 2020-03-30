import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/album.dart';
import '../datasources/moor_music_data_source.dart';

class AlbumModel extends Album {
  AlbumModel({
    this.id,
    @required String title,
    @required String artist,
    String albumArtPath,
    int pubYear,
  }) : super(
          title: title,
          artist: artist,
          albumArtPath: albumArtPath,
          pubYear: pubYear,
        );

  factory AlbumModel.fromMoorAlbum(MoorAlbum moorAlbum) => AlbumModel(
        title: moorAlbum.title,
        artist: moorAlbum.artist,
        albumArtPath: moorAlbum.albumArtPath,
        pubYear: moorAlbum.year,
      );

  factory AlbumModel.fromAlbumInfo(AlbumInfo albumInfo) {
    final String _year = albumInfo.firstYear;

    return AlbumModel(
      title: albumInfo.title,
      artist: albumInfo.artist,
      albumArtPath: albumInfo.albumArt,
      pubYear: _year == null ? null : int.parse(_year),
    );
  }

  final int id;

  AlbumsCompanion toAlbumsCompanion() => AlbumsCompanion(
        title: Value(title),
        artist: Value(artist),
        albumArtPath: Value(albumArtPath),
        year: Value(pubYear),
      );
}
