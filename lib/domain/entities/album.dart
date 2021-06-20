import 'package:equatable/equatable.dart';

class Album extends Equatable {
  const Album({
    required this.title,
    required this.artist,
    this.albumArtPath,
    this.pubYear,
  });

  final String title;
  final String artist;
  final int? pubYear;
  final String? albumArtPath;

  @override
  List<Object?> get props => [title, artist, albumArtPath, pubYear];
}
