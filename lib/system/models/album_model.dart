import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/album.dart';
import '../datasources/moor_music_data_source.dart';

class AlbumModel extends Album {
  const AlbumModel({
    this.id,
    @required String title,
    @required String artist,
    String albumArtPath,
    int year,
  }) : super(
          title: title,
          artist: artist,
          albumArtPath: albumArtPath,
          pubYear: year,
        );

  factory AlbumModel.fromMoorAlbum(MoorAlbum moorAlbum) => AlbumModel(
        id: moorAlbum.id,
        title: moorAlbum.title,
        artist: moorAlbum.artist,
        albumArtPath: moorAlbum.albumArtPath,
        year: moorAlbum.year,
      );

  factory AlbumModel.fromAlbumInfo(AlbumInfo albumInfo) {
    final String _year = albumInfo.firstYear;

    return AlbumModel(
      id: int.parse(albumInfo.id),
      title: albumInfo.title,
      artist: albumInfo.artist,
      albumArtPath: albumInfo.albumArt,
      year: _year == null ? null : int.parse(_year),
    );
  }

  final int id;

  @override
  String toString() {
    return '$title';
  }

  AlbumModel copyWith({
    String artist,
    String title,
    int id,
    int year,
    String albumArtPath,
  }) =>
      AlbumModel(
          artist: artist ?? this.artist,
          title: title ?? this.title,
          id: id ?? this.id,
          year: year ?? pubYear,
          albumArtPath: albumArtPath ?? this.albumArtPath);

  AlbumsCompanion toAlbumsCompanion() => AlbumsCompanion(
        title: Value(title),
        artist: Value(artist),
        albumArtPath: Value(albumArtPath),
        year: Value(pubYear),
      );
}
