import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../state/music_data_store.dart';
import '../theming.dart';
import '../utils.dart' as utils;

class ExcludeLevelOptions extends StatelessWidget {
  const ExcludeLevelOptions({
    Key? key,
    required this.songs,
    required this.musicDataStore,
    this.callback,
  }) : super(key: key);

  final List<Song> songs;
  final MusicDataStore musicDataStore;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    final lvl = _commonBlockLevel(songs);

    return Container(
      // color: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.only(
          left: HORIZONTAL_PADDING - 12,
          right: HORIZONTAL_PADDING - 12,
          top: 4.0,
          bottom: 4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (lvl != 0) {
                  musicDataStore.setSongsBlocked(songs, 0);
                  if (callback != null) callback!();
                }
              },
              icon: Icon(utils.blockLevelIcon(0)),
              color: lvl == 0 ? LIGHT2 : Colors.white38,
            ),
            IconButton(
              onPressed: () {
                if (lvl != 1) {
                  musicDataStore.setSongsBlocked(songs, 1);
                  if (callback != null) callback!();
                }
              },
              icon: Icon(utils.blockLevelIcon(1)),
              color: lvl == 1 ? LIGHT2 : Colors.white38,
            ),
            IconButton(
              onPressed: () {
                if (lvl != 2) {
                  musicDataStore.setSongsBlocked(songs, 2);
                  if (callback != null) callback!();
                }
              },
              icon: Icon(utils.blockLevelIcon(2)),
              color: lvl == 2 ? LIGHT2 : Colors.white38,
            ),
            IconButton(
              onPressed: () {
                if (lvl != 3) {
                  musicDataStore.setSongsBlocked(songs, 3);
                  if (callback != null) callback!();
                }
              },
              icon: Icon(utils.blockLevelIcon(3)),
              color: lvl == 3 ? LIGHT2 : Colors.white38,
            ),
          ],
        ),
      ),
    );
  }

  int? _commonBlockLevel(List<Song> songs) {
    int? lvl;

    for (final s in songs) {
      if (lvl == null) {
        lvl = s.blockLevel;
      } else if (s.blockLevel != lvl) {
        return null;
      }
    }

    return lvl;
  }
}
