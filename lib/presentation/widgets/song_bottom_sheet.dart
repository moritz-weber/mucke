import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/playlist.dart';
import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../theming.dart';
import 'song_info.dart';

class SongBottomSheet {
  void call(Song song, BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: DARK2,
      builder: (context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 2,
                color: LIGHT1,
              ),
              ListTile(
                title: const Text('Play next'),
                leading: const Icon(Icons.play_arrow_rounded),
                onTap: () {
                  audioStore.playNext(song);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Add to queue'),
                leading: const Icon(Icons.queue_rounded),
                onTap: () {
                  audioStore.addToQueue(song);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Add to playlist'),
                leading: const Icon(Icons.playlist_add_rounded),
                onTap: () {
                  Navigator.pop(context);
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
                                          musicDataStore.addSongToPlaylist(playlist, song);
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) =>
                                        const SizedBox(
                                      height: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
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
              ),
              ListTile(
                title: song.blocked ? const Text('Unblock song') : const Text('Block song'),
                leading: song.blocked
                    ? const Icon(Icons.check_circle_outline_rounded)
                    : const Icon(Icons.remove_circle_outline_rounded),
                onTap: () {
                  musicDataStore.setSongBlocked(song, !song.blocked);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Show song info'),
                leading: const Icon(Icons.info),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        backgroundColor: DARK3,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(HORIZONTAL_PADDING),
                            child: SongInfo(song),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Close',
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
