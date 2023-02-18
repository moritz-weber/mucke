import 'package:audio_service/audio_service.dart';
import 'package:drift/drift.dart';
import 'package:on_audio_query/on_audio_query.dart' as aq;

import '../../domain/entities/song.dart';
import '../datasources/drift_database.dart';
import '../utils.dart';
import 'default_values.dart';

class SongModel extends Song {
  const SongModel({
    required String title,
    required String album,
    required int albumId,
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
    required int playCount,
    required DateTime timeAdded,
    required this.lastModified,
    int? year,
  }) : super(
          album: album,
          albumId: albumId,
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
          playCount: playCount,
          timeAdded: timeAdded,
          year: year,
        );

  factory SongModel.fromDrift(DriftSong driftSong) => SongModel(
        album: driftSong.albumTitle,
        albumId: driftSong.albumId,
        artist: driftSong.artist,
        blockLevel: driftSong.blockLevel,
        duration: Duration(milliseconds: driftSong.duration),
        path: driftSong.path,
        title: driftSong.title,
        albumArtPath: driftSong.albumArtPath,
        discNumber: driftSong.discNumber,
        next: driftSong.next,
        previous: driftSong.previous,
        trackNumber: driftSong.trackNumber,
        likeCount: driftSong.likeCount,
        playCount: driftSong.playCount,
        timeAdded: driftSong.timeAdded,
        lastModified: driftSong.lastModified,
        year: driftSong.year,
      );

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
      year: parseYear(data['year'] as String?),
      timeAdded: DateTime.fromMillisecondsSinceEpoch(0),
      lastModified: lastModified,
    );
  }

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
        playCount: Value(playCount),
        timeAdded: Value(timeAdded),
        lastModified: Value(lastModified),
      );

  SongsCompanion toDriftInsert() => SongsCompanion(
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
            'timeAdded': timeAdded.millisecondsSinceEpoch,
          });

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
