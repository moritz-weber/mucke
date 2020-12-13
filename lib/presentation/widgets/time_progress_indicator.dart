import 'dart:math';

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
        final int duration = audioStore.currentSong?.duration ?? 1000;

        return Row(
          children: [
            Container(
              width: 48,
              child: Text(
                msToTimeString(audioStore.currentPositionStream.value),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 3.0,
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: min(
                      audioStore.currentPositionStream.value / duration, 1.0),
                  heightFactor: 1.0,
                  child: Container(
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 48,
              alignment: Alignment.centerRight,
              child: Text(msToTimeString(duration)),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );
  }
}
