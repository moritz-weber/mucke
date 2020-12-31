import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/loop_mode.dart';
import '../state/audio_store.dart';

class LoopButton extends StatelessWidget {
  const LoopButton({Key key, this.iconSize = 20.0}) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        if (audioStore.loopModeStream != null) {
          switch (audioStore.loopModeStream.value) {
            case LoopMode.off:
              return IconButton(
                icon: const Icon(
                  Icons.repeat_rounded,
                  color: Colors.white24,
                ),
                iconSize: iconSize,
                onPressed: () {
                  audioStore.setLoopMode(LoopMode.all);
                },
              );
            case LoopMode.one:
              return IconButton(
                icon: const Icon(
                  Icons.repeat_one_rounded,
                  color: Colors.white,
                ),
                iconSize: iconSize,
                onPressed: () {
                  audioStore.setLoopMode(LoopMode.off);
                },
              );
            case LoopMode.all:
              return IconButton(
                icon: const Icon(
                  Icons.repeat_rounded,
                  color: Colors.white,
                ),
                iconSize: iconSize,
                onPressed: () {
                  audioStore.setLoopMode(LoopMode.one);
                },
              );
          }
        }
        return Container();
      },
    );
  }
}
