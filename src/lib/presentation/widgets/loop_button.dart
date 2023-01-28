import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/loop_mode.dart';
import '../state/audio_store.dart';

class LoopButton extends StatelessWidget {
  const LoopButton({
    Key? key,
    this.iconSize = 20.0,
  }) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
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
              splashRadius: iconSize / 2 + 6.0,
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
              splashRadius: iconSize / 2 + 6.0,
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
              splashRadius: iconSize / 2 + 6.0,
            );
          case null:
            return Container();
        }
      },
    );
  }
}
