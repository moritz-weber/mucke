import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/audio_store.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
    this.iconSize = 24.0,
  }) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final hasNext = audioStore.hasNext;

        if (hasNext) {
          return IconButton(
            icon: const Icon(Icons.skip_next_rounded),
            iconSize: iconSize,
            onPressed: audioStore.skipToNext,
            splashRadius: iconSize / 2 + 6.0,
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
