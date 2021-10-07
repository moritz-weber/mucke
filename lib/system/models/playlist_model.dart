import 'package:moor/moor.dart' as m;

import '../../domain/entities/playlist.dart';
import '../datasources/moor_database.dart';
import 'song_model.dart';

class PlaylistModel extends Playlist {
  const PlaylistModel({
    required int id,
    required String name,
    required List<SongModel> songs,
  }) : super(
          id: id,
          name: name,
          songs: songs,
        );

  factory PlaylistModel.fromMoor(MoorPlaylist moorPlaylist, List<MoorSong> songs) {
    return PlaylistModel(
      id: moorPlaylist.id,
      name: moorPlaylist.name,
      songs: songs.map((e) => SongModel.fromMoor(e)).toList(),
    );
  }

  PlaylistsCompanion toCompanion() => PlaylistsCompanion(
        id: m.Value(id),
        name: m.Value(name),
      );
}
