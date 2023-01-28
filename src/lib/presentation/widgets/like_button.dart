import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../constants.dart';
import '../../domain/entities/song.dart';
import '../state/music_data_store.dart';
import '../utils.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    required this.song,
    this.iconSize = 20.0,
    this.visualDensity = VisualDensity.compact,
  }) : super(key: key);

  final double iconSize;
  final Song song;
  final VisualDensity visualDensity;

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();

    return IconButton(
      iconSize: iconSize,
      icon: Icon(
        likeCountIcon(song.likeCount),
        color: likeCountColor(song.likeCount),
      ),
      onPressed: () {
        if (song.likeCount < MAX_LIKE_COUNT) {
          musicDataStore.setLikeCount([song], song.likeCount + 1);
        } else {
          musicDataStore.setLikeCount([song], 0);
        }
      },
      visualDensity: visualDensity,
    );
  }
}
