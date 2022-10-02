import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/audio_store.dart';
import '../utils.dart';

class TimeProgressIndicator extends StatefulWidget {
  const TimeProgressIndicator({Key? key}) : super(key: key);

  @override
  State<TimeProgressIndicator> createState() => _TimeProgressIndicatorState();
}

class _TimeProgressIndicatorState extends State<TimeProgressIndicator> {
  bool useLocalPosition = false;
  double localPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final duration = audioStore.currentSongStream.value?.duration ?? const Duration(minutes: 1);
        final sliderWidth = useLocalPosition
            ? localPosition
            : _position(audioStore.currentPositionStream.value?.inMilliseconds ?? 0,
                duration.inMilliseconds);

        return Row(
          children: [
            Container(
              width: 44,
              child: Text(
                msToTimeString(
                  audioStore.currentPositionStream.value ?? const Duration(seconds: 0),
                ),
              ),
            ),
            Expanded(
              child: Slider(
                value: sliderWidth,
                activeColor: Colors.white,
                inactiveColor: Colors.white10,
                onChanged: (value) {
                  setState(() {
                    localPosition = value;
                  });
                },
                onChangeStart: (value) {
                  setState(() {
                    localPosition = value;
                    useLocalPosition = true;
                  });
                },
                onChangeEnd: (value) {
                  setState(() {
                    useLocalPosition = false;
                  });
                  audioStore.seekToPosition(value);
                },
              ),
            ),
            Container(
              width: 44,
              alignment: Alignment.centerRight,
              child: Text(msToTimeString(duration)),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );
  }

  double _position(int position, int duration) {
    final res = position / duration;
    return min(1.0, max(0.0, res));
  }
}
