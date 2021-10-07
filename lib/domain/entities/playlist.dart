import 'package:equatable/equatable.dart';

import 'song.dart';

class Playlist extends Equatable {
  const Playlist({
    required this.id,
    required this.name,
    required this.songs,
  });

  final int id;
  final String name;
  final List<Song> songs;

  @override
  List<Object?> get props => [id, name];
}
