import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/audio_store.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key? key,
    this.circle = false,
    this.iconSize = 24.0,
  }) : super(key: key);

  final bool circle;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        if (audioStore.playingStream.value != null && (audioStore.playingStream.value ?? false)) {
          return IconButton(
            icon: circle
                ? const Icon(Icons.pause_circle_filled_rounded)
                : const Icon(Icons.pause_rounded),
            iconSize: iconSize,
            onPressed: () {
              audioStore.pause();
            },
          );
        } else {
          return IconButton(
            icon: circle
                ? const Icon(Icons.play_circle_filled_rounded)
                : const Icon(Icons.play_arrow_rounded),
            iconSize: iconSize,
            onPressed: () {
              audioStore.play();
            },
          );
        }
      },
    );
  }
}
