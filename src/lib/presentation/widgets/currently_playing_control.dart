import 'package:flutter/material.dart';

import 'playback_control.dart';
import 'song_customization_buttons.dart';
import 'time_progress_indicator.dart';

class CurrentlyPlayingControl extends StatelessWidget {
  const CurrentlyPlayingControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0 + 2.0),
          child: SongCustomizationButtons(),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0 + 2.0),
          child: PlaybackControl(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.0 - 4.0, right: 12.0 - 4.0),
          child: TimeProgressIndicator(),
        ),
      ],
    );
  }
}
