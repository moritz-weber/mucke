import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../constants.dart';
import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../utils.dart';

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
              likeCountIcon(0),
              size: iconSize,
              color: Colors.white24,
            ),
            onPressed: () {},
            visualDensity: VisualDensity.compact,
          );
        }

        final likeCountColors = [
          Colors.white24,
          Colors.white54,
          Colors.white70,
          Theme.of(context).highlightColor,
        ];

        return IconButton(
          icon: Icon(
            likeCountIcon(song.likeCount),
            size: iconSize,
            color: likeCountColors[song.likeCount],
          ),
          onPressed: () {
            if (song.likeCount < MAX_LIKE_COUNT) {
              musicDataStore.incrementLikeCount(song);
            } else {
              musicDataStore.resetLikeCount(song);
            }
          },
          visualDensity: VisualDensity.compact,
        );
      },
    );
  }
}