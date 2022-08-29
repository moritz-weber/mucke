import 'package:drift/drift.dart' as m;

import '../../domain/entities/playlist.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../datasources/moor_database.dart';
import 'song_model.dart';

class PlaylistModel extends Playlist {
  const PlaylistModel({
    required int id,
    required String name,
    required List<SongModel> songs,
    required String iconString,
    required String gradientString,
    ShuffleMode? shuffleMode,
  }) : super(
          id: id,
          name: name,
          songs: songs,
          iconString: iconString,
          gradientString: gradientString,
          shuffleMode: shuffleMode,
        );

  factory PlaylistModel.fromMoor(MoorPlaylist moorPlaylist, List<MoorSong> songs) {
    return PlaylistModel(
      id: moorPlaylist.id,
      name: moorPlaylist.name,
      songs: songs.map((e) => SongModel.fromMoor(e)).toList(),
      iconString: moorPlaylist.icon,
      gradientString: moorPlaylist.gradient,
      shuffleMode: moorPlaylist.shuffleMode?.toShuffleMode(),
    );
  }

  PlaylistsCompanion toCompanion() => PlaylistsCompanion(
        id: m.Value(id),
        name: m.Value(name),
        shuffleMode: m.Value(shuffleMode?.toString()),
        icon: m.Value(iconString),
        gradient: m.Value(gradientString),
      );
}
