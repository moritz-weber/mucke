import 'package:audio_service/audio_service.dart';
import 'package:audiotagger/models/audiofile.dart';
import 'package:audiotagger/models/tag.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/song.dart';
import '../datasources/moor_database.dart';
import 'default_values.dart';

class SongModel extends Song {
  const SongModel({
    required String title,
    required String album,
    required this.albumId,
    required String artist,
    required String path,
    required int duration,
    required bool blocked,
    String? albumArtPath,
    required int discNumber,
    required String next,
    required String previous,
    required int trackNumber,
    required int likeCount,
    required int skipCount,
    required int playCount,
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
    required String path,
    required Tag tag,
    required AudioFile audioFile,
    String? albumArtPath,
    required int albumId,
  }) {
    return SongModel(
      // TODO: wo am besten default werte unterbringen? db oder hier?
      title: tag.title ?? DEF_TITLE,
      artist: tag.artist ?? DEF_ARTIST,
      album: tag.album ?? DEF_ALBUM,
      albumId: albumId,
      path: path,
      duration: (audioFile.length ?? DEF_DURATION) * 1000,
      blocked: false,
      discNumber: _parseNumber(tag.discNumber),
      trackNumber: _parseNumber(tag.trackNumber),
      albumArtPath: albumArtPath,
      next: '',
      previous: '',
      likeCount: 0,
      playCount: 0,
      skipCount: 0,
    );
  }

  factory SongModel.fromMediaItem(MediaItem mediaItem) {
    final String? artUri = mediaItem.artUri?.path.replaceFirst('file://', '');

    final int discNumber = mediaItem.extras!['discNumber'] as int;
    final int trackNumber = mediaItem.extras!['trackNumber'] as int;

    return SongModel(
      album: mediaItem.album,
      albumId: mediaItem.extras!['albumId'] as int,
      artist: mediaItem.artist!,
      duration: mediaItem.duration!.inMilliseconds,
      blocked: mediaItem.extras!['blocked'] as bool,
      path: mediaItem.id,
      title: mediaItem.title,
      albumArtPath: artUri,
      discNumber: discNumber,
      next: mediaItem.extras!['next'] as String,
      previous: mediaItem.extras!['previous'] as String,
      trackNumber: trackNumber,
      likeCount: mediaItem.extras!['likeCount'] as int,
      playCount: mediaItem.extras!['playCount'] as int,
      skipCount: mediaItem.extras!['skipCount'] as int,
    );
  }

  final int albumId;

  @override
  String toString() {
    return '$title';
  }

  SongModel copyWith({
    String? album,
    int? albumId,
    String? artist,
    bool? blocked,
    int? duration,
    String? path,
    String? title,
    String? albumArtPath,
    int? discNumber,
    String? next,
    String? previous,
    int? trackNumber,
    int? likeCount,
    int? skipCount,
    int? playCount,
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
        blocked: Value(blocked),
        present: const Value(true),
        next: Value(next),
        previous: Value(previous),
        likeCount: Value(likeCount),
        skipCount: Value(skipCount),
        playCount: Value(playCount),
      );

  MediaItem toMediaItem() => MediaItem(
          id: path,
          title: title,
          album: album,
          artist: artist,
          duration: Duration(milliseconds: duration),
          artUri: Uri.file('$albumArtPath'),
          extras: {
            'albumId': albumId,
            'blocked': blocked,
            'discNumber': discNumber,
            'trackNumber': trackNumber,
            'next': next,
            'previous': previous,
            'likeCount': likeCount,
            'playCount': playCount,
            'skipCount': skipCount,
          });

  static int _parseNumber(String? numberString) {
    if (numberString == null || numberString == '') {
      return 1;
    }
    return int.parse(numberString);
  }
}

// TODO: maybe move to another file
extension SongModelExtension on MediaItem {
  String get previous => extras!['previous'] as String;
  String get next => extras!['next'] as String;
}
