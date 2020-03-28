import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Song extends Equatable {
  Song({
    @required this.title,
    @required this.album,
    @required this.artist,
    @required this.path,
    this.trackNumber,
    this.albumArtPath,
  });

  final String title;
  final String album;
  final String artist;
  final int trackNumber;
  final String path;
  final String albumArtPath;

  @override
  List<Object> get props => [title, album, artist];
}
