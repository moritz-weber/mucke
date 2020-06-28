import 'package:audio_service/audio_service.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/song.dart';
import '../datasources/moor_music_data_source.dart';

class SongModel extends Song {
  SongModel({
    @required String title,
    @required String album,
    @required String artist,
    @required String path,
    @required int duration,
    int trackNumber,
    String albumArtPath,
    this.albumId
  }) : super(
          title: title,
          album: album,
          artist: artist,
          path: path,
          duration: duration,
          trackNumber: trackNumber,
          albumArtPath: albumArtPath,
        );

  factory SongModel.fromMoorSong(MoorSong moorSong) => SongModel(
        title: moorSong.title,
        artist: moorSong.artist,
        album: moorSong.albumTitle,
        albumId: moorSong.albumId,
        path: moorSong.path,
        duration: moorSong.duration,
        albumArtPath: moorSong.albumArtPath,
        trackNumber: moorSong.trackNumber,
      );

  factory SongModel.fromSongInfo(SongInfo songInfo) {
    final String trackNumber = songInfo.track;
    final String duration = songInfo.duration;

    return SongModel(
      title: songInfo.title,
      artist: songInfo.artist,
      album: songInfo.album,
      albumId: int.parse(songInfo.albumId),
      path: songInfo.filePath,
      duration: duration == null ? null : int.parse(duration),
      albumArtPath: songInfo.albumArtwork,
      trackNumber: trackNumber == null ? null : int.parse(trackNumber),
    );
  }

  // TODO: test
  factory SongModel.fromMediaItem(MediaItem mediaItem) {
    if (mediaItem == null) {
      return null;
    }

    final String artUri = mediaItem.artUri?.replaceFirst('file://', '');

    return SongModel(
      title: mediaItem.title,
      album: mediaItem.album,
      artist: mediaItem.artist,
      path: mediaItem.id,
      duration: mediaItem.duration.inMilliseconds,
      albumArtPath: artUri,
    );
  }

  int albumId;

  SongsCompanion toSongsCompanion() => SongsCompanion(
        albumTitle: Value(album),
        albumId: Value(albumId),
        artist: Value(artist),
        title: Value(title),
        path: Value(path),
        duration: Value(duration),
        albumArtPath: Value(albumArtPath),
        trackNumber: Value(trackNumber),
      );

  MediaItem toMediaItem() => MediaItem(
        id: path,
        title: title,
        album: album,
        artist: artist,
        duration: Duration(milliseconds: duration),
        artUri: 'file://$albumArtPath',
      );
}
