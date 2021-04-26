import 'package:audio_service/audio_service.dart';
import 'package:audiotagger/models/audiofile.dart';
import 'package:audiotagger/models/tag.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/song.dart';
import '../datasources/moor_database.dart';

class SongModel extends Song {
  const SongModel({
    @required String title,
    @required String album,
    @required this.albumId,
    @required String artist,
    @required String path,
    @required int duration,
    @required bool blocked,
    String albumArtPath,
    int discNumber,
    String next,
    String previous,
    int trackNumber,
    int likeCount,
    int skipCount,
    int playCount,
  }) : super(
          album: album,
          artist: artist,
          blocked: blocked,
          duration: duration,
          path: path,
          title: title,
          albumArtPath: albumArtPath,
          discNumber: discNumber,
          next: next,
          previous: previous,
          trackNumber: trackNumber,
          likeCount: likeCount,
          skipCount: skipCount,
          playCount: playCount,
        );

  factory SongModel.fromMoor(MoorSong moorSong) => SongModel(
        album: moorSong.albumTitle,
        albumId: moorSong.albumId,
        artist: moorSong.artist,
        blocked: moorSong.blocked,
        duration: moorSong.duration,
        path: moorSong.path,
        title: moorSong.title,
        albumArtPath: moorSong.albumArtPath,
        discNumber: moorSong.discNumber,
        next: moorSong.next,
        previous: moorSong.previous,
        trackNumber: moorSong.trackNumber,
        likeCount: moorSong.likeCount,
        skipCount: moorSong.skipCount,
        playCount: moorSong.playCount,
      );

  factory SongModel.fromAudiotagger({
    String path,
    Tag tag,
    AudioFile audioFile,
    String albumArtPath,
    int albumId,
  }) {
    return SongModel(
      title: tag.title,
      artist: tag.artist,
      album: tag.album,
      albumId: albumId,
      path: path,
      duration: audioFile.length * 1000,
      blocked: false,
      discNumber: _parseDiscNumber(tag.discNumber),
      trackNumber: int.parse(tag.trackNumber),
      albumArtPath: albumArtPath,
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
      album: mediaItem.album,
      albumId: mediaItem.extras['albumId'] as int,
      artist: mediaItem.artist,
      duration: mediaItem.duration.inMilliseconds,
      blocked: mediaItem.extras['blocked'] as bool,
      path: mediaItem.id,
      title: mediaItem.title,
      albumArtPath: artUri,
      discNumber: discNumber,
      next: mediaItem.extras['next'] as String,
      previous: mediaItem.extras['previous'] as String,
      trackNumber: trackNumber,
    );
  }

  final int albumId;

  @override
  String toString() {
    return '$title';
  }

  SongModel copyWith({
    String album,
    int albumId,
    String artist,
    bool blocked,
    int duration,
    String path,
    String title,
    String albumArtPath,
    int discNumber,
    String next,
    String previous,
    int trackNumber,
    int likeCount,
    int skipCount,
    int playCount,
  }) =>
      SongModel(
        album: album ?? this.album,
        albumId: albumId ?? this.albumId,
        artist: artist ?? this.artist,
        blocked: blocked ?? this.blocked,
        duration: duration ?? this.duration,
        path: path ?? this.path,
        title: title ?? this.title,
        albumArtPath: albumArtPath ?? this.albumArtPath,
        discNumber: discNumber ?? this.discNumber,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        trackNumber: trackNumber ?? this.trackNumber,
        likeCount: likeCount ?? this.likeCount,
        skipCount: skipCount ?? this.skipCount,
        playCount: playCount ?? this.playCount,
      );

  SongsCompanion toSongsCompanion() => SongsCompanion(
        albumTitle: Value(album),
        albumId: Value(albumId),
        artist: Value(artist),
        blocked: Value(blocked),
        duration: Value(duration),
        path: Value(path),
        title: Value(title),
        albumArtPath: Value(albumArtPath),
        discNumber: Value(discNumber),
        next: Value(next),
        previous: Value(previous),
        trackNumber: Value(trackNumber),
        likeCount: Value(likeCount),
        skipCount: Value(skipCount),
        playCount: Value(playCount),
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
            'blocked': blocked,
            'discNumber': discNumber,
            'next': next,
            'previous': previous,
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

  static int _parseDiscNumber(String discNumberString) {
    if (discNumberString == null || discNumberString == '') {
      return 1;
    }
    return int.parse(discNumberString);
  }
}

// TODO: maybe move to another file
extension SongModelExtension on MediaItem {
  String get previous => extras['previous'] as String;
  String get next => extras['next'] as String;
}
