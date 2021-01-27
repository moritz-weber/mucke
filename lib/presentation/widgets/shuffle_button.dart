import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../state/audio_store.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key key, this.iconSize = 20.0}) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        if (audioStore.shuffleModeStream != null) {
          switch (audioStore.shuffleModeStream.value) {
            case ShuffleMode.none:
              return IconButton(
                icon: const Icon(
                  Icons.shuffle_rounded,
                  color: Colors.white30,
                ),
                iconSize: iconSize,
                onPressed: () => audioStore.setShuffleMode(ShuffleMode.standard),
              );
            case ShuffleMode.standard:
              return IconButton(
                icon: const Icon(
                  Icons.shuffle_rounded,
                  color: Colors.white,
                ),
                iconSize: iconSize,
                onPressed: () => audioStore.setShuffleMode(ShuffleMode.plus),
              );
            case ShuffleMode.plus:
              return IconButton(
                icon: Icon(
                  Icons.fingerprint_rounded,
                  color: Theme.of(context).accentColor,
                ),
                iconSize: iconSize,
                onPressed: () => audioStore.setShuffleMode(ShuffleMode.none),
              );
          }
        }
        return Container();
      },
    );
  }
}
