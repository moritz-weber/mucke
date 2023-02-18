import 'package:drift/drift.dart' as m;

import '../../domain/entities/playlist.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../datasources/drift_database.dart';

class PlaylistModel extends Playlist {
  const PlaylistModel({
    required int id,
    required String name,
    required String iconString,
    required String gradientString,
    required DateTime timeCreated,
    required DateTime timeChanged,
    required DateTime timeLastPlayed,
    ShuffleMode? shuffleMode,
  }) : super(
          id: id,
          name: name,
          iconString: iconString,
          gradientString: gradientString,
          shuffleMode: shuffleMode,
          timeCreated: timeCreated,
          timeChanged: timeChanged,
          timeLastPlayed: timeLastPlayed,
        );

  factory PlaylistModel.fromPlaylist(Playlist playlist) {
    return PlaylistModel(
      id: playlist.id,
      name: playlist.name,
      iconString: playlist.iconString,
      gradientString: playlist.gradientString,
      shuffleMode: playlist.shuffleMode,
      timeChanged: playlist.timeChanged,
      timeCreated: playlist.timeCreated,
      timeLastPlayed: playlist.timeLastPlayed,
    );
  }

  factory PlaylistModel.fromDrift(DriftPlaylist driftPlaylist) {
    return PlaylistModel(
      id: driftPlaylist.id,
      name: driftPlaylist.name,
      iconString: driftPlaylist.icon,
      gradientString: driftPlaylist.gradient,
      shuffleMode: driftPlaylist.shuffleMode?.toShuffleMode(),
      timeChanged: driftPlaylist.timeChanged,
      timeCreated: driftPlaylist.timeCreated,
      timeLastPlayed: driftPlaylist.timeLastPlayed,
    );
  }

  PlaylistsCompanion toCompanion() => PlaylistsCompanion(
        id: m.Value(id),
        name: m.Value(name),
        shuffleMode: m.Value(shuffleMode?.toString()),
        icon: m.Value(iconString),
        gradient: m.Value(gradientString),
        timeChanged: m.Value(timeChanged),
        timeCreated: m.Value(timeCreated),
        timeLastPlayed: m.Value(timeLastPlayed),
      );
}
