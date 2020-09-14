import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../state/audio_store.dart';

class ShuffleIndicator extends StatelessWidget {
  const ShuffleIndicator({Key key, this.verticalPad, this.horizontalPad})
      : super(key: key);

  final double verticalPad;
  final double horizontalPad;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Container(
      child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: verticalPad,
            horizontal: horizontalPad,
          ),
          child: Observer(
            builder: (BuildContext context) {
              if (audioStore.shuffleModeStream != null) {
                final mode = audioStore.shuffleModeStream.value;
                switch (mode) {
                  case ShuffleMode.none:
                    return Icon(Icons.music_note);
                  case ShuffleMode.standard:
                    return Icon(Icons.shuffle);
                  case ShuffleMode.plus:
                    return Icon(Icons.plus_one);
                }
              }
              return Container();
            },
          )),
    );
  }
}
