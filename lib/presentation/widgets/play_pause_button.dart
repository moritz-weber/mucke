import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/playback_state.dart';
import '../state/audio_store.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({Key key, this.circle = false, this.iconSize = 24.0}) : super(key: key);

  final bool circle;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        switch (audioStore.playbackStateStream.value) {
          case PlaybackState.playing:
            return IconButton(
              icon: circle ? const Icon(Icons.pause_circle_filled) : const Icon(Icons.pause),
              iconSize: iconSize,
              onPressed: () {
                audioStore.pause();
              },
            );
          case PlaybackState.paused:
            return IconButton(
              icon: circle ? const Icon(Icons.play_circle_filled) : const Icon(Icons.play_arrow),
              iconSize: iconSize,
              onPressed: () {
                audioStore.play();
              },
            );
          default:
            return Container(height: 0, width: 0,);
        }
      },
    );
  }
}