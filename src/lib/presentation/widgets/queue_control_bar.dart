import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../theming.dart';
import 'playback_control.dart';

class QueueControlBar extends StatelessWidget {
  const QueueControlBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final Song? song = audioStore.currentSongStream.value;
        final Duration position =
            audioStore.currentPositionStream.value ?? const Duration(seconds: 0);
        if (song != null) {
          return Column(
            verticalDirection: VerticalDirection.up,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Material(
                color: DARK3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING + 2, vertical: 8.0),
                  child: PlaybackControl(),
                ),
              ),
              Container(
                child: LinearProgressIndicator(
                  value: position.inMilliseconds / song.duration.inMilliseconds,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  backgroundColor: Colors.white10,
                ),
                height: 2,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
