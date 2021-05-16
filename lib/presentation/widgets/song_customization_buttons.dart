import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../theming.dart';
import 'like_button.dart';

class SongCustomizationButtons extends StatelessWidget {
  const SongCustomizationButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final Song song = audioStore.currentSongStream.value;
        return Container(
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  song.next == '' && song.previous == '' ? Icons.link_off : Icons.link,
                  color: _linkColor(song),
                ),
                iconSize: 20.0,
                onPressed: () => _editLinks(context),
                visualDensity: VisualDensity.compact,
              ),
              const LikeButton(
                iconSize: 20.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.remove_circle_outline_rounded,
                  size: 20.0,
                  color: song.blocked ? Colors.white : Colors.white24,
                ),
                onPressed: () => musicDataStore.setSongBlocked(song, !song.blocked),
                visualDensity: VisualDensity.compact,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        );
      },
    );
  }

  Color _linkColor(Song song) {
    if (song.next != '' && song.previous != '') {
      return LIGHT1;
    } else if (song.next != '') {
      return Colors.red;
    } else if (song.previous != '') {
      return Colors.blue;
    }
    return Colors.white24;
  }

  void _editLinks(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final AudioStore audioStore = GetIt.I<AudioStore>();

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: DARK2,
      builder: (context) {
        return Container(
          child: Observer(
            builder: (BuildContext context) {
              final song = audioStore.currentSongStream.value;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 2,
                    color: LIGHT1,
                  ),
                  SwitchListTile(
                    title: const Text('Always play previous song before'),
                    value: song.previous != '',
                    onChanged: (bool value) {
                      musicDataStore.togglePreviousSongLink(song);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Always play next song after'),
                    value: song.next != '',
                    onChanged: (bool value) {
                      musicDataStore.toggleNextSongLink(song);
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
