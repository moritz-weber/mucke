import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../domain/entities/playlist.dart';
import '../../../domain/entities/song.dart';
import '../../state/music_data_store.dart';
import '../../theming.dart';

class AddToPlaylistTile extends StatelessWidget {
  const AddToPlaylistTile({Key? key, required this.songs, required this.musicDataStore}) : super(key: key);

  final List<Song> songs;
  final MusicDataStore musicDataStore;

  @override
  Widget build(BuildContext context) {
    return ListTile(
          title: Text(L10n.of(context)!.addToPlaylist),
          leading: const Icon(Icons.playlist_add_rounded),
          onTap: () {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Observer(
                  builder: (context) {
                    final playlists = musicDataStore.playlistsStream.value ?? [];
                    return SimpleDialog(
                      backgroundColor: DARK3,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(HORIZONTAL_PADDING),
                          child: Container(
                            height: 300.0,
                            width: 300.0,
                            child: ListView.separated(
                              itemCount: playlists.length,
                              itemBuilder: (_, int index) {
                                final Playlist playlist = playlists[index];
                                return ListTile(
                                  title: Text(playlist.name),
                                  onTap: () {
                                    musicDataStore.addSongsToPlaylist(playlist, songs);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => const SizedBox(
                                height: 4.0,
                              ),
                            ),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            L10n.of(context)!.cancel,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
  }
}