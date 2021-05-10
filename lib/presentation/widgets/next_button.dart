import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/loop_mode.dart';
import '../state/audio_store.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key key, this.iconSize = 24.0}) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final queue = audioStore.queueStream.value;
        final int index = audioStore.queueIndexStream.value;
        final LoopMode loopMode = audioStore.loopModeStream.value;

        if ((index != null && index < queue.length - 1) || loopMode != LoopMode.off) {
          return IconButton(
            icon: const Icon(Icons.skip_next_rounded),
            iconSize: iconSize,
            onPressed: () {
              // precacheImage(FileImage(File(queue[index+2].albumArtPath)), context);
              return audioStore.skipToNext();
            },
            
          );
        }
        return IconButton(
          icon: const Icon(
            Icons.skip_next_rounded,
          ),
          iconSize: iconSize,
          onPressed: null,
        );
      },
    );
  }
}
