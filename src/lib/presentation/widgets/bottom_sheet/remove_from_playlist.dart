import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import '../../../domain/entities/playlist.dart';
import '../../state/music_data_store.dart';

class RemoveFromPlaylistTile extends StatelessWidget {
  const RemoveFromPlaylistTile({
    Key? key,
    required this.songPositions,
    required this.musicDataStore,
    required this.playlist,
    this.callback,
  }) : super(key: key);

  final List<int> songPositions;
  final Playlist playlist;
  final MusicDataStore musicDataStore;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(L10n.of(context)!.removeFromPlaylist),
      leading: const Icon(Icons.playlist_remove_rounded),
      onTap: () {
        songPositions.sort();
        for (final i in songPositions.reversed) {
          musicDataStore.removePlaylistEntry(playlist.id, i);
        }
        callback?.call();
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
  }
}
