import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
                  onTap: () {
                    audioStore.playNext(song);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Add to queue'),
                  onTap: () {
                    audioStore.addToQueue(song);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: song.blocked ? const Text('Unblock song') : const Text('Block song'),
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
                        });
                  },
                ),
              ],
            ),
          );
        });
  }
}
