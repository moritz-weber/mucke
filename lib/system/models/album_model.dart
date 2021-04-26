import 'package:audiotagger/models/tag.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/album.dart';
import '../datasources/moor_database.dart';

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

  factory AlbumModel.fromMoor(MoorAlbum moorAlbum) => AlbumModel(
        id: moorAlbum.id,
        title: moorAlbum.title,
        artist: moorAlbum.artist,
        albumArtPath: moorAlbum.albumArtPath,
        year: moorAlbum.year,
      );

  factory AlbumModel.fromAudiotagger({Tag tag, int albumId, String albumArtPath}) {
    return AlbumModel(
      id: albumId,
      title: tag.album,
      artist: tag.albumArtist,
      albumArtPath: albumArtPath,
      year: tag.year == null ? null : _parseYear(tag.year),
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
        id: Value(id),
        title: Value(title),
        artist: Value(artist),
        albumArtPath: Value(albumArtPath),
        year: Value(pubYear),
      );

  static int _parseYear(String yearString) {
    if (yearString == null || yearString == '') {
      return null;
    }
    
    try {
      return int.parse(yearString);
    } on FormatException {
      return int.parse(yearString.split('-')[0]);
    }
  }
}
