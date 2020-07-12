import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../state/audio_store.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({Key key, this.iconSize = 24.0}) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        final int index = audioStore.queueIndexStream.value; //

        if (index > 0) { //
          return IconButton(
            icon: Icon(Icons.skip_previous), //
            iconSize: iconSize,
            onPressed: () {
              audioStore.skipToPrevious(); //
            },
            
          );
        }
        return IconButton(
          icon: Icon(
            Icons.skip_previous,
          ),
          iconSize: iconSize,
          onPressed: null,
        );
      },
    );
  }
}
