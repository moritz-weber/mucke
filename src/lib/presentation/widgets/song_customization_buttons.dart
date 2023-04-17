import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
                  linkIcon(song.previous, song.next),
                  color: linkColor(song.previous, song.next),
                ),
                iconSize: 24.0,
                onPressed: () => _editLinks(context),
              ),
              LikeButton(
                iconSize: 28.0,
                song: song,
                visualDensity: VisualDensity.standard,
              ),
              IconButton(
                icon: Icon(
                  blockLevelIcon(song.blockLevel),
                  size: 24.0,
                  color: song.blockLevel == 0 ? Colors.white24 : Colors.white,
                ),
                onPressed: () => _editBlockLevel(context),
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

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MyBottomSheet(
        widgets: [
          Observer(builder: (context) {
            final song = audioStore.currentSongStream.value;
            if (song == null) return Container();
            final firstLast = musicDataStore.isSongFirstLast(song);
            return FutureBuilder(
                future: firstLast,
                builder: (context, AsyncSnapshot<List<bool>> snapshot) {
                  if (snapshot.hasData)
                    return SwitchListTile(
                      title: Text(L10n.of(context)!.alwaysPlayPrevious),
                      value: song.previous,
                      onChanged: snapshot.data![0]
                          ? null
                          : (bool value) {
                              musicDataStore.togglePreviousSongLink(song);
                            },
                    );
                  return Container();
                });
          }),
          Observer(builder: (context) {
            final song = audioStore.currentSongStream.value;
            if (song == null) return Container();
            final firstLast = musicDataStore.isSongFirstLast(song);
            return FutureBuilder(
                future: firstLast,
                builder: (context, AsyncSnapshot<List<bool>> snapshot) {
                  if (snapshot.hasData)
                    return SwitchListTile(
                      title: Text(L10n.of(context)!.alwaysPlayNext),
                      value: song.next,
                      onChanged: snapshot.data![1]
                          ? null
                          : (bool value) {
                              musicDataStore.toggleNextSongLink(song);
                            },
                    );
                  return Container();
                });
          }),
        ],
      ),
    );
  }

  void _editBlockLevel(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final AudioStore audioStore = GetIt.I<AudioStore>();

    const TextStyle _active = TextStyle(color: Colors.white);
    const TextStyle _inactive = TextStyle(color: Colors.white54);

    final descriptions = <String>[
      L10n.of(context)!.dontExcludeSong,
      L10n.of(context)!.excludeShuffleAllSong,
      L10n.of(context)!.excludeShuffleSong,
      L10n.of(context)!.alwaysExcludeSong,
    ];

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MyBottomSheet(
        widgets: List<Widget>.generate(
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
                  musicDataStore.setSongsBlocked([song], index);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
