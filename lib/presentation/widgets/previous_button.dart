import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/audio_store.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({Key key, this.iconSize = 24.0}) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return IconButton(
      icon: const Icon(Icons.skip_previous_rounded),
      iconSize: iconSize,
      onPressed: () {
        audioStore.skipToPrevious();
      },
    );
  }
}
