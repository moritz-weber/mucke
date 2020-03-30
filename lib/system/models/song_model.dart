import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/song.dart';
import '../datasources/moor_music_data_source.dart';

class SongModel extends Song {
  SongModel({
    this.id,
    @required String title,
    @required String album,
    @required String artist,
    @required String path,
    int trackNumber,
    String albumArtPath,
  }) : super(
          title: title,
          album: album,
          artist: artist,
          path: path,
          trackNumber: trackNumber,
          albumArtPath: albumArtPath,
        );

  factory SongModel.fromMoorSong(MoorSong moorSong) => SongModel(
        title: moorSong.title,
        artist: moorSong.artist,
        album: moorSong.album,
        path: moorSong.path,
        albumArtPath: moorSong.albumArtPath,
        trackNumber: moorSong.trackNumber,
      );

  factory SongModel.fromSongInfo(SongInfo songInfo) {
    final String _trackNumber = songInfo.track;

    return SongModel(
      title: songInfo.title,
      artist: songInfo.artist,
      albumArtPath: songInfo.albumArtwork,
      album: songInfo.album,
      path: songInfo.filePath,
      trackNumber: _trackNumber == null ? null : int.parse(_trackNumber),
    );
  }

  final int id;

  SongsCompanion toSongsCompanion() => SongsCompanion(
        album: Value(album),
        artist: Value(artist),
        title: Value(title),
        path: Value(path),
        albumArtPath: Value(albumArtPath),
        trackNumber: Value(trackNumber),
      );
}
