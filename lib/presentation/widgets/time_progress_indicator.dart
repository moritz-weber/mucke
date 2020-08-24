import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../state/audio_store.dart';
import '../utils.dart';

class TimeProgressIndicator extends StatelessWidget {
  const TimeProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        final int duration = audioStore.song?.duration ?? 1000;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(msToTimeString(audioStore.currentPositionStream.value)),
              Container(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: LinearProgressIndicator(value: audioStore.currentPositionStream.value / duration),
                  height: 3.0,
                ),
              ),
              Container(
                width: 10,
              ),
              Text(msToTimeString(duration)),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        );
      },
    );
  }
}
