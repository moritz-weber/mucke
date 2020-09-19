import 'package:audio_service/audio_service.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/song.dart';
import '../datasources/moor_music_data_source.dart';

class SongModel extends Song {
  const SongModel(
      {@required String title,
      @required String album,
      @required this.albumId,
      @required String artist,
      @required String path,
      @required int duration,
      @required bool blocked,
      int trackNumber,
      String albumArtPath})
      : super(
          title: title,
          album: album,
          artist: artist,
          path: path,
          duration: duration,
          blocked: blocked,
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
        blocked: moorSong.blocked,
        trackNumber: moorSong.trackNumber,
        albumArtPath: moorSong.albumArtPath,
      );

  factory SongModel.fromSongInfo(SongInfo songInfo) {
    final String duration = songInfo.duration;

    return SongModel(
      title: songInfo.title,
      artist: songInfo.artist,
      album: songInfo.album,
      albumId: int.parse(songInfo.albumId),
      path: songInfo.filePath,
      duration: duration == null ? null : int.parse(duration),
      blocked: false,
      albumArtPath: songInfo.albumArtwork,
      trackNumber: _parseTrackNumber(songInfo.track),
    );
  }

  factory SongModel.fromMediaItem(MediaItem mediaItem) {
    if (mediaItem == null) {
      return null;
    }

    final String artUri = mediaItem.artUri?.replaceFirst('file://', '');
    final tn = mediaItem.extras['trackNumber'];
    int trackNumber;

    if (tn == null) {
      trackNumber = null;
    } else {
      trackNumber = tn as int;
    }

    return SongModel(
      title: mediaItem.title,
      album: mediaItem.album,
      albumId: mediaItem.extras['albumId'] as int,
      artist: mediaItem.artist,
      path: mediaItem.id,
      duration: mediaItem.duration.inMilliseconds,
      blocked: mediaItem.extras['blocked'] == 'true',
      albumArtPath: artUri,
      trackNumber: trackNumber,
    );
  }

  final int albumId;

  @override
  String toString() {
    return '$title';
  }

  SongModel copyWith({
    String title,
    String album,
    String artist,
    String path,
    int duration,
    bool blocked,
    int trackNumber,
    String albumArtPath,
    int albumId,
  }) =>
      SongModel(
        album: album ?? this.album,
        artist: artist ?? this.artist,
        duration: duration ?? this.duration,
        path: path ?? this.path,
        title: title ?? this.title,
        blocked: blocked ?? this.blocked,
        trackNumber: trackNumber ?? this.trackNumber,
        albumArtPath: albumArtPath ?? this.albumArtPath,
        albumId: albumId ?? this.albumId,
      );

  SongsCompanion toSongsCompanion() => SongsCompanion(
        albumTitle: Value(album),
        albumId: Value(albumId),
        artist: Value(artist),
        title: Value(title),
        path: Value(path),
        duration: Value(duration),
        blocked: Value(blocked),
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
          extras: {
            'albumId': albumId,
            'blocked': blocked.toString(),
            'trackNumber': trackNumber,
          });

  static int _parseTrackNumber(String trackNumberString) {
    int trackNumber;
    if (trackNumberString == null) {
      return null;
    }

    trackNumber = int.tryParse(trackNumberString);
    if (trackNumber == null) {
      if (trackNumberString.contains('/')) {
        trackNumber = int.tryParse(trackNumberString.split('/')[0]);
      }
    }
    return trackNumber;
  }
}
