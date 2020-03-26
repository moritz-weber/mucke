import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Album extends Equatable {
  Album({
    @required this.title,
    @required this.artist,
    this.albumArtPath,
    this.year,
  });

  final String title;
  final String artist;
  final int year;
  final String albumArtPath;

  @override
  List<Object> get props => [title, artist, albumArtPath, year];
}
