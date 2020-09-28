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
      int discNumber,
      int trackNumber,
      String albumArtPath})
      : super(
          title: title,
          album: album,
          artist: artist,
          path: path,
          duration: duration,
          blocked: blocked,
          discNumber: discNumber,
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
        discNumber: moorSong.discNumber,
        trackNumber: moorSong.trackNumber,
        albumArtPath: moorSong.albumArtPath,
      );

  factory SongModel.fromSongInfo(SongInfo songInfo) {
    final String duration = songInfo.duration;
    final List<int> numbers = _parseTrackNumber(songInfo.track);

    return SongModel(
      title: songInfo.title,
      artist: songInfo.artist,
      album: songInfo.album,
      albumId: int.parse(songInfo.albumId),
      path: songInfo.filePath,
      duration: duration == null ? null : int.parse(duration),
      blocked: false,
      discNumber: numbers[0],
      trackNumber: numbers[1],
      albumArtPath: songInfo.albumArtwork,
    );
  }

  factory SongModel.fromMediaItem(MediaItem mediaItem) {
    if (mediaItem == null) {
      return null;
    }

    final String artUri = mediaItem.artUri?.replaceFirst('file://', '');
    
    final dn = mediaItem.extras['discNumber'];
    int discNumber;
    final tn = mediaItem.extras['trackNumber'];
    int trackNumber;

    if (tn == null) {
      trackNumber = null;
    } else {
      trackNumber = tn as int;
    }

    if (dn == null) {
      discNumber = null;
    } else {
      discNumber = dn as int;
    }

    return SongModel(
      title: mediaItem.title,
      album: mediaItem.album,
      albumId: mediaItem.extras['albumId'] as int,
      artist: mediaItem.artist,
      path: mediaItem.id,
      duration: mediaItem.duration.inMilliseconds,
      blocked: mediaItem.extras['blocked'] == 'true',
      discNumber: discNumber,
      trackNumber: trackNumber,
      albumArtPath: artUri,
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
    int discNumber,
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
        discNumber: discNumber ?? this.discNumber,
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
        discNumber: Value(discNumber),
        trackNumber: Value(trackNumber),
        albumArtPath: Value(albumArtPath),
      );

  SongsCompanion toMoorInsert() => SongsCompanion(
        albumTitle: Value(album),
        albumId: Value(albumId),
        artist: Value(artist),
        title: Value(title),
        path: Value(path),
        duration: Value(duration),
        albumArtPath: Value(albumArtPath),
        discNumber: Value(discNumber),
        trackNumber: Value(trackNumber),
        // blocked: Value(blocked),
        present: const Value(true),
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
            'discNumber': discNumber,
            'trackNumber': trackNumber,
          });

  static List<int> _parseTrackNumber(String trackNumberString) {
    int discNumber = 1;
    int trackNumber;
  
    if (trackNumberString == null) {
      return [null, null];
    }

    trackNumber = int.tryParse(trackNumberString);
    if (trackNumber == null) {
      if (trackNumberString.contains('/')) {
        discNumber = int.tryParse(trackNumberString.split('/')[0]);
        trackNumber = int.tryParse(trackNumberString.split('/')[1]);
      }
    } else if (trackNumber > 1000) {
      discNumber = int.tryParse(trackNumberString.substring(0, 1));
      trackNumber = int.tryParse(trackNumberString.substring(1));
    }
    return [discNumber, trackNumber];
  }
}
