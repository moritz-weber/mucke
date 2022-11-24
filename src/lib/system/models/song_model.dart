import 'package:audio_service/audio_service.dart';
import 'package:audiotagger/models/audiofile.dart';
import 'package:audiotagger/models/tag.dart';
import 'package:drift/drift.dart';
import 'package:on_audio_query/on_audio_query.dart' as aq;

import '../../domain/entities/song.dart';
import '../datasources/moor_database.dart';
import '../utils.dart';
import 'default_values.dart';

class SongModel extends Song {
  const SongModel({
    required String title,
    required String album,
    required this.albumId,
    required String artist,
    required String path,
    required Duration duration,
    required int blockLevel,
    String? albumArtPath,
    required int discNumber,
    required bool next,
    required bool previous,
    required int trackNumber,
    required int likeCount,
    required int skipCount,
    required int playCount,
    required DateTime timeAdded,
    required this.lastModified,
    int? year,
  }) : super(
          album: album,
          artist: artist,
          blockLevel: blockLevel,
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
          timeAdded: timeAdded,
          year: year,
        );

  factory SongModel.fromMoor(MoorSong moorSong) => SongModel(
        album: moorSong.albumTitle,
        albumId: moorSong.albumId,
        artist: moorSong.artist,
        blockLevel: moorSong.blockLevel,
        duration: Duration(milliseconds: moorSong.duration),
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
        timeAdded: moorSong.timeAdded,
        lastModified: moorSong.lastModified,
        year: moorSong.year,
      );

  factory SongModel.fromAudiotagger({
    required String path,
    required Tag tag,
    required AudioFile audioFile,
    String? albumArtPath,
    required int albumId,
    required DateTime lastModified,
  }) {
    return SongModel(
      title: tag.title ?? DEF_TITLE,
      artist: tag.artist ?? DEF_ARTIST,
      album: tag.album ?? DEF_ALBUM,
      albumId: albumId,
      path: path,
      duration: Duration(milliseconds: (audioFile.length ?? DEF_DURATION) * 1000),
      blockLevel: 0,
      discNumber: _parseNumber(tag.discNumber),
      trackNumber: _parseNumber(tag.trackNumber),
      albumArtPath: albumArtPath,
      next: false,
      previous: false,
      likeCount: 0,
      playCount: 0,
      skipCount: 0,
      year: parseYear(tag.year),
      timeAdded: DateTime.fromMillisecondsSinceEpoch(0),
      lastModified: lastModified,
    );
  }

  factory SongModel.fromOnAudioQuery({
    required String path,
    required aq.SongModel songModel,
    String? albumArtPath,
    required int albumId,
    required DateTime lastModified,
  }) {

    final data = songModel.getMap;
    final trackNumber = _parseTrackNumber(songModel.track);

    return SongModel(
      title: songModel.title,
      artist: songModel.artist ?? DEF_ARTIST,
      album: songModel.album ?? DEF_ALBUM,
      albumId: albumId,
      path: path,
      duration: Duration(milliseconds: songModel.duration ?? DEF_DURATION),
      blockLevel: 0,
      discNumber: trackNumber[0],
      trackNumber: trackNumber[1],
      albumArtPath: albumArtPath,
      next: false,
      previous: false,
      likeCount: 0,
      playCount: 0,
      skipCount: 0,
      year: parseYear(data['year'] as String?),
      timeAdded: DateTime.fromMillisecondsSinceEpoch(0),
      lastModified: lastModified,
    );
  }

  final int albumId;
  final DateTime lastModified;

  @override
  String toString() {
    return '$title';
  }

  SongModel copyWith({
    String? album,
    int? albumId,
    String? artist,
    int? blockLevel,
    Duration? duration,
    String? path,
    String? title,
    String? albumArtPath,
    int? discNumber,
    bool? next,
    bool? previous,
    int? trackNumber,
    int? likeCount,
    int? skipCount,
    int? playCount,
    DateTime? timeAdded,
    DateTime? lastModified,
    int? year,
  }) =>
      SongModel(
        album: album ?? this.album,
        albumId: albumId ?? this.albumId,
        artist: artist ?? this.artist,
        blockLevel: blockLevel ?? this.blockLevel,
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
        timeAdded: timeAdded ?? this.timeAdded,
        lastModified: lastModified ?? this.lastModified,
        year: year ?? this.year,
      );

  SongsCompanion toSongsCompanion() => SongsCompanion(
        albumTitle: Value(album),
        albumId: Value(albumId),
        artist: Value(artist),
        blockLevel: Value(blockLevel),
        duration: Value(duration.inMilliseconds),
        path: Value(path),
        title: Value(title),
        albumArtPath: Value(albumArtPath),
        discNumber: Value(discNumber),
        year: Value(year),
        next: Value(next),
        previous: Value(previous),
        trackNumber: Value(trackNumber),
        likeCount: Value(likeCount),
        skipCount: Value(skipCount),
        playCount: Value(playCount),
        timeAdded: Value(timeAdded),
        lastModified: Value(lastModified),
      );

  SongsCompanion toMoorInsert() => SongsCompanion(
        albumTitle: Value(album),
        albumId: Value(albumId),
        artist: Value(artist),
        title: Value(title),
        path: Value(path),
        duration: Value(duration.inMilliseconds),
        albumArtPath: Value(albumArtPath),
        discNumber: Value(discNumber),
        trackNumber: Value(trackNumber),
        year: Value(year),
        present: const Value(true),
        lastModified: Value(lastModified),
      );

  MediaItem toMediaItem() => MediaItem(
          id: path,
          title: title,
          album: album,
          artist: artist,
          duration: duration,
          artUri: Uri.file('$albumArtPath'),
          extras: {
            'albumId': albumId,
            'blockLevel': blockLevel,
            'discNumber': discNumber,
            'trackNumber': trackNumber,
            'year': year,
            'next': next,
            'previous': previous,
            'likeCount': likeCount,
            'playCount': playCount,
            'skipCount': skipCount,
            'timeAdded': timeAdded.millisecondsSinceEpoch,
          });

  static int _parseNumber(String? numberString) {
    if (numberString == null || numberString == '') {
      return 1;
    }
    return int.parse(numberString);
  }

  static List<int> _parseTrackNumber(int? number) {
    if (number == null) return [1, 1];

    final numString = number.toString();
    final firstZero = numString.indexOf('0');

    if (firstZero < 0 || firstZero == numString.length - 1) {
      return [1, number];
    }

    final disc = numString.substring(0, firstZero);
    final track = numString.substring(firstZero + 1);

    return [int.parse(disc), int.parse(track)];
  }
}

// TODO: maybe move to another file
extension SongModelExtension on MediaItem {
  String get previous => extras!['previous'] as String;
  String get next => extras!['next'] as String;
}
