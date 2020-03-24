import 'package:equatable/equatable.dart';

class Song extends Equatable {
  final String title;
  final String album;
  final String artist;
  final int trackNumber;
  final String path;
  final String albumArtPath;

  Song(this.title, this.album, this.artist, this.trackNumber, this.path,
      this.albumArtPath);

  @override
  List<Object> get props => [title, album, artist];
}
