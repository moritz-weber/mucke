import 'package:flutter/material.dart';

import 'loop_button.dart';
import 'next_button.dart';
import 'play_pause_button.dart';
import 'previous_button.dart';
import 'shuffle_button.dart';

class PlaybackControl extends StatelessWidget {
  const PlaybackControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        LoopButton(iconSize: 20.0),
        PreviousButton(iconSize: 32.0),
        PlayPauseButton(
          circle: true,
          iconSize: 52.0,
        ),
        NextButton(iconSize: 32.0),
        ShuffleButton(
          iconSize: 20.0,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
