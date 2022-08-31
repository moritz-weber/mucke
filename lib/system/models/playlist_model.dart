import 'package:drift/drift.dart' as m;

import '../../domain/entities/playlist.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../datasources/moor_database.dart';

class PlaylistModel extends Playlist {
  const PlaylistModel({
    required int id,
    required String name,
    required String iconString,
    required String gradientString,
    ShuffleMode? shuffleMode,
  }) : super(
          id: id,
          name: name,
          iconString: iconString,
          gradientString: gradientString,
          shuffleMode: shuffleMode,
        );

  factory PlaylistModel.fromPlaylist(Playlist playlist) {
    return PlaylistModel(
      id: playlist.id,
      name: playlist.name,
      iconString: playlist.iconString,
      gradientString: playlist.gradientString,
      shuffleMode: playlist.shuffleMode,
    );
  }

  factory PlaylistModel.fromMoor(MoorPlaylist moorPlaylist) {
    return PlaylistModel(
      id: moorPlaylist.id,
      name: moorPlaylist.name,
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
