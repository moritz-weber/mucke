import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'synced_lyrics.dart';

class Song extends Equatable {
  const Song({
    required this.album,
    required this.albumId,
    required this.artist,
    required this.blockLevel,
    required this.duration,
    required this.path,
    required this.title,
    required this.likeCount,
    required this.playCount,
    required this.discNumber,
    required this.next,
    required this.previous,
    required this.timeAdded,
    required this.trackNumber,
    this.albumArtPath,
    this.color,
    this.year,
    this.lyrics,
    this.syncedLyrics,
  });

  final String album;
  final int albumId;
  final String artist;

  /// 0: not blocked, 3: always blocked
  final int blockLevel;

  final Duration duration;
  final String path;
  final String title;

  final int likeCount;
  final int playCount;

  final int discNumber;
  final int trackNumber;
  
  final bool next;
  final bool previous;

  final String? albumArtPath;
  final Color? color;
  final int? year;
  final String? lyrics;
  final SyncedLyrics? syncedLyrics;

  final DateTime timeAdded;

  bool get hasPlainLyrics => (lyrics != null && lyrics!.isNotEmpty) || hasSyncedLyrics;

  bool get hasSyncedLyrics => syncedLyrics != null && syncedLyrics!.hasLines;

  /// The lyrics to display: the stringified synced lyrics when available,
  /// otherwise the plain `lyrics` text.
  String? get plainLyrics =>
      hasSyncedLyrics ? syncedLyrics!.toString() : lyrics;

  @override
  List<Object?> get props => [
        path,
        title,
        album,
        artist,
        year,
        blockLevel,
        next,
        previous,
        likeCount,
        playCount,
        timeAdded,
      ];
}
