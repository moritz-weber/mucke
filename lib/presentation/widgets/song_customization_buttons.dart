import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../theming.dart';
import '../utils.dart';
import 'custom_modal_bottom_sheet.dart';
import 'like_button.dart';

class SongCustomizationButtons extends StatelessWidget {
  const SongCustomizationButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: linkColor(song),
                ),
                iconSize: 20.0,
                onPressed: () => _editLinks(context),
                visualDensity: VisualDensity.compact,
              ),
              Observer(
                builder: (context) => LikeButton(
                  iconSize: 20.0,
                  song: song,
                ),
              ),
              IconButton(
                icon: Icon(
                  blockLevelIcon(song.blockLevel),
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

  void _editLinks(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final AudioStore audioStore = GetIt.I<AudioStore>();

    CustomModalBottomSheet()(
      context,
      [
        Observer(builder: (context) {
          final song = audioStore.currentSongStream.value;
          if (song == null) return Container();
          return SwitchListTile(
            title: const Text('Always play previous song before'),
            value: song.previous,
            onChanged: (bool value) {
              musicDataStore.togglePreviousSongLink(song);
            },
          );
        }),
        Observer(builder: (context) {
          final song = audioStore.currentSongStream.value;
          if (song == null) return Container();
          return SwitchListTile(
            title: const Text('Always play next song after'),
            value: song.next,
            onChanged: (bool value) {
              musicDataStore.toggleNextSongLink(song);
            },
          );
        }),
      ],
    );
  }

  void _editBlockLevel(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final AudioStore audioStore = GetIt.I<AudioStore>();

    const TextStyle _active = TextStyle(color: Colors.white);
    const TextStyle _inactive = TextStyle(color: Colors.white54);

    const descriptions = <String>[
      "Don't exclude this song.",
      'Exclude when shuffling all songs.',
      'Exclude when shuffling.',
      'Always exclude this song.'
    ];

    CustomModalBottomSheet()(
      context,
      List.generate(
        descriptions.length,
        (index) => Observer(
          builder: (BuildContext context) {
            final song = audioStore.currentSongStream.value;
            if (song == null) return Container();
            return ListTile(
              title: Text(
                descriptions[index],
                style: song.blockLevel == index ? _active : _inactive,
              ),
              leading: Icon(
                blockLevelIcon(index),
                size: 24.0,
                color: song.blockLevel == index ? LIGHT1 : Colors.white54,
              ),
              enabled: song.blockLevel != index,
              onTap: () {
                musicDataStore.setSongBlocked(song, index);
              },
            );
          },
        ),
      ),
    );
  }
}
