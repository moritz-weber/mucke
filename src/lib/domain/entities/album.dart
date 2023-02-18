import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'playable.dart';

class Album extends Equatable implements Playable{
  const Album({
    required this.id,
    required this.title,
    required this.artist,
    this.albumArtPath,
    this.color,
    this.pubYear,
  });

  final int id;
  @override
  final String title;
  final String artist;
  final int? pubYear;
  final String? albumArtPath;
  final Color? color;

  @override
  List<Object?> get props => [id, title, artist, albumArtPath, pubYear];

  @override
  PlayableType get type => PlayableType.album;
  
  @override
  String get identifier => id.toString();
}
