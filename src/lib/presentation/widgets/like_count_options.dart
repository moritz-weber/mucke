import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../state/music_data_store.dart';
import '../theming.dart';
import '../utils.dart' as utils;

class LikeCountOptions extends StatelessWidget {
  const LikeCountOptions({
    Key? key,
    required this.songs,
    required this.musicDataStore,
  }) : super(key: key);

  final List<Song> songs;
  final MusicDataStore musicDataStore;

  @override
  Widget build(BuildContext context) {

    final lvl = _commonLikeCount(songs);

    return Container(
      color: Colors.white10,
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
                if (lvl != 0) musicDataStore.setLikeCount(songs, 0);
              },
              icon: Icon(utils.likeCountIcon(0)),
              color: lvl == 0 ? LIGHT2 : Colors.white38,
            ),
            IconButton(
              onPressed: () {
                if (lvl != 1) musicDataStore.setLikeCount(songs, 1);
              },
              icon: Icon(utils.likeCountIcon(1)),
              color: lvl == 1 ? LIGHT2 : Colors.white38,
            ),
            IconButton(
              onPressed: () {
                if (lvl != 2) musicDataStore.setLikeCount(songs, 2);
              },
              icon: Icon(utils.likeCountIcon(2)),
              color: lvl == 2 ? LIGHT2 : Colors.white38,
            ),
            IconButton(
              onPressed: () {
                if (lvl != 3) musicDataStore.setLikeCount(songs, 3);
              },
              icon: Icon(utils.likeCountIcon(3)),
              color: lvl == 3 ? LIGHT2 : Colors.white38,
            ),
          ],
        ),
      ),
    );
  }

  int? _commonLikeCount(List<Song> songs) {
    int? count;

    for (final s in songs) {
      if (count == null) {
        count = s.likeCount;
      } else if (s.likeCount != count) {
        return null;
      }
    }

    return count;
  }
}
