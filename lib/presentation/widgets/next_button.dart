import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../state/audio_store.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key key, this.iconSize = 24.0}) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        final queue = audioStore.queueStream.value;
        final int index = audioStore.queueIndexStream.value;

        if (index != null && index < queue.length - 1) {
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
            Icons.skip_next,
          ),
          iconSize: iconSize,
          onPressed: null,
        );
      },
    );
  }
}
