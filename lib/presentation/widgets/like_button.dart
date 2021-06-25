import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../theming.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    this.iconSize = 20.0,
  }) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final Song? song = audioStore.currentSongStream.value;

        if (song == null) {
          return IconButton(
            icon: Icon(
              Icons.favorite_rounded,
              size: iconSize,
              color: Colors.white24,
            ),
            onPressed: () {},
            visualDensity: VisualDensity.compact,
          );
        }

        if (song.likeCount == 0) {
          return IconButton(
            icon: Icon(
              Icons.favorite_rounded,
              size: iconSize,
              color: Colors.white24,
            ),
            onPressed: () => musicDataStore.incrementLikeCount(song),
            visualDensity: VisualDensity.compact,
          );
        } else {
          return IconButton(
            icon: Stack(
              children: [
                Icon(
                  Icons.favorite_rounded,
                  color: Theme.of(context).accentColor,
                  size: iconSize,
                ),
                Text(
                  song.likeCount.toString(),
                  style: const TextStyle(
                    color: DARK1,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              alignment: AlignmentDirectional.center,
            ),
            onPressed: () {
              if (song.likeCount < 5) {
                musicDataStore.incrementLikeCount(song);
              } else {
                musicDataStore.resetLikeCount(song);
              }
            },
            visualDensity: VisualDensity.compact,
          );
        }
      },
    );
  }
}
