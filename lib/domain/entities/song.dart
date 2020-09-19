import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Song extends Equatable {
  const Song({
    @required this.title,
    @required this.album,
    @required this.artist,
    @required this.path,
    @required this.duration,
    @required this.blocked,
    this.trackNumber,
    this.albumArtPath,
  });

  final String title;
  final String album;
  final String artist;
  final String path;
  /// Duration in milliseconds.
  final int duration;
  final int trackNumber;
  final String albumArtPath;
  /// Is this song blocked in shuffle mode?
  final bool blocked;

  @override
  List<Object> get props => [title, album, artist];
}
