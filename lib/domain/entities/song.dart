import 'package:equatable/equatable.dart';

class Song extends Equatable {
  const Song({
    required this.album,
    required this.artist,
    required this.blocked,
    required this.duration,
    required this.path,
    required this.title,
    required this.likeCount,
    required this.skipCount,
    required this.playCount,
    required this.discNumber,
    required this.next,
    required this.previous,
    required this.trackNumber,
    this.albumArtPath,
  });

  final String album;
  final String artist;

  /// Is this song blocked in shuffle mode?
  final bool blocked;

  /// Duration in milliseconds.
  final int duration;
  final String path;
  final String title;

  final int likeCount;
  final int skipCount;
  final int playCount;

  final int discNumber;
  final int trackNumber;
  
  final String next;
  final String previous;

  final String? albumArtPath;

  @override
  List<Object?> get props => [
        path,
        title,
        album,
        artist,
        blocked,
        next,
        previous,
        likeCount,
        playCount,
        skipCount,
      ];
}
