import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Song extends Equatable {
  const Song({
    @required this.album,
    @required this.artist,
    @required this.blocked,
    @required this.duration,
    @required this.path,
    @required this.title,
    this.albumArtPath,
    this.discNumber,
    this.next,
    this.previous,
    this.trackNumber,
    this.likeCount,
    this.skipCount,
    this.playCount,
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

  final String albumArtPath;
  final int discNumber;
  final String next;
  final String previous;
  final int trackNumber;

  @override
  List<Object> get props => [
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
