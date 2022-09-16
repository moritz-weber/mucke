import 'package:audiotagger/models/tag.dart';
import 'package:drift/drift.dart';

import '../../domain/entities/album.dart';
import '../datasources/moor_database.dart';
import '../utils.dart';
import 'default_values.dart';

class AlbumModel extends Album {
  const AlbumModel({
    required this.id,
    required String title,
    required String artist,
    String? albumArtPath,
    int? year,
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

  factory AlbumModel.fromAudiotagger({
    required Tag tag,
    required int albumId,
    String? albumArtPath,
  }) {
    final artist = tag.albumArtist != '' ? tag.albumArtist : tag.artist;

    return AlbumModel(
      id: albumId,
      title: tag.album ?? DEF_ALBUM,
      artist: artist ?? DEF_ARTIST,
      albumArtPath: albumArtPath,
      year: tag.year == null ? null : parseYear(tag.year!),
    );
  }

  final int id;

  @override
  String toString() {
    return '$title';
  }

  AlbumModel copyWith({
    String? artist,
    String? title,
    int? id,
    int? year,
    String? albumArtPath,
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
}

class AlbumOfDay {
  AlbumOfDay(this.albumModel, this.date);

  final AlbumModel albumModel;
  final DateTime date;

  String toJSON() {
    return '{"id": ${albumModel.id}, "date": ${date.millisecondsSinceEpoch}}';
  }
}
