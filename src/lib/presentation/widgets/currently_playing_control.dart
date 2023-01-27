import 'package:flutter/material.dart';

import 'playback_control.dart';
import 'song_customization_buttons.dart';
import 'time_progress_indicator.dart';

class CurrentlyPlayingControl extends StatelessWidget {
  const CurrentlyPlayingControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0 + 2.0),
          child: SongCustomizationButtons(),
        ),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0 + 2.0),
          child: PlaybackControl(),
        ),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.only(left: 12.0 - 4.0, right: 12.0 - 4.0),
          child: TimeProgressIndicator(),
        ),
        SizedBox(height: 8.0),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Icon(
              Icons.expand_less_rounded,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
