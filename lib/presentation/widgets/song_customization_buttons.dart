import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../theming.dart';
import 'like_button.dart';

class SongCustomizationButtons extends StatelessWidget {
  const SongCustomizationButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final Song? song = audioStore.currentSongStream.value;

        if (song == null) {
          return Container();
        }

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
                  _blockIcon(song.blockLevel),
                  size: 20.0,
                  color: song.blockLevel == 0 ? Colors.white24 : Colors.white,
                ),
                onPressed: () => _editBlockLevel(context),
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
              if (song == null) {
                return Container();
              }
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

  IconData _blockIcon(int blockLevel) {
    switch (blockLevel) {
      case 1:
        return Icons.sentiment_neutral_rounded;
      case 2:
        return Icons.sentiment_dissatisfied_rounded;
      case 3:
        return Icons.sentiment_very_dissatisfied_rounded;
      default:
        return Icons.sentiment_satisfied_rounded;
    }
  }

  void _editBlockLevel(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final AudioStore audioStore = GetIt.I<AudioStore>();

    const TextStyle _active = TextStyle(color: Colors.white);
    const TextStyle _inactive = TextStyle(color: Colors.white54);

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: DARK2,
      builder: (context) {
        return Container(
          child: Observer(
            builder: (BuildContext context) {
              final song = audioStore.currentSongStream.value;
              if (song == null) {
                return Container();
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 2,
                    color: LIGHT1,
                  ),
                  ListTile(
                    title: Text(
                      "Don't exclude this song.",
                      style: song.blockLevel == 0 ? _active : _inactive,
                    ),
                    leading: Icon(
                      Icons.sentiment_satisfied_rounded,
                      color: song.blockLevel == 0 ? LIGHT1 : Colors.white54,
                    ),
                    enabled: song.blockLevel != 0,
                    onTap: () {
                      musicDataStore.setSongBlocked(song, 0);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Exclude when shuffling all songs.',
                      style: song.blockLevel == 1 ? _active : _inactive,
                    ),
                    leading: Icon(
                      Icons.sentiment_neutral_rounded,
                      color: song.blockLevel == 1 ? LIGHT1 : Colors.white54,
                    ),
                    enabled: song.blockLevel != 1,
                    onTap: () {
                      musicDataStore.setSongBlocked(song, 1);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Exclude when shuffling.',
                      style: song.blockLevel == 2 ? _active : _inactive,
                    ),
                    leading: Icon(
                      Icons.sentiment_dissatisfied_rounded,
                      color: song.blockLevel == 2 ? LIGHT1 : Colors.white54,
                    ),
                    enabled: song.blockLevel != 2,
                    onTap: () {
                      musicDataStore.setSongBlocked(song, 2);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Always exclude this song.',
                      style: song.blockLevel == 3 ? _active : _inactive,
                    ),
                    leading: Icon(
                      Icons.sentiment_very_dissatisfied_rounded,
                      color: song.blockLevel == 3 ? LIGHT1 : Colors.white54,
                    ),
                    enabled: song.blockLevel != 3,
                    onTap: () {
                      musicDataStore.setSongBlocked(song, 3);
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
