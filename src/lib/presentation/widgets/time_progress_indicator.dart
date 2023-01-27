import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/audio_store.dart';
import '../utils.dart';

class TimeProgressIndicator extends StatelessWidget {
  const TimeProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomTimeIndicator(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Observer(builder: (context) {
                return Text(audioStore.positionString);
              }),
              Observer(
                builder: (context) {
                  final duration =
                      audioStore.currentSongStream.value?.duration ?? const Duration(minutes: 1);
                  return Text(msToTimeString(duration));
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ],
    );
  }
}

class CustomTimeIndicator extends StatefulWidget {
  const CustomTimeIndicator({Key? key}) : super(key: key);

  @override
  _CustomTimeIndicatorState createState() => _CustomTimeIndicatorState();
}

class _CustomTimeIndicatorState extends State<CustomTimeIndicator> {
  bool useLocalPosition = false;
  double localPosition = 0.0;
  final AudioStore audioStore = GetIt.I<AudioStore>();

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0, elevation: 0.0),
      ),
      child: Observer(
        builder: (context) {
          final duration =
              audioStore.currentSongStream.value?.duration ?? const Duration(minutes: 1);
          final sliderWidth = useLocalPosition
              ? localPosition
              : _position(audioStore.currentPositionStream.value, duration);
          return Slider(
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
          );
        },
      ),
    );
  }

  double _position(Duration? position, Duration duration) {
    if (position == null) return 0;
    final res = position.inMilliseconds / duration.inMilliseconds;
    return min(1.0, max(0.0, res));
  }
}
