import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/audio_store.dart';
import 'next_song.dart';

class NextIndicator extends StatelessWidget {
  const NextIndicator({Key key, this.onTapAction}) : super(key: key);

  final void Function(BuildContext) onTapAction;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final queue = audioStore.queueStream.value;
        final int index = audioStore.queueIndexStream.value;

        return GestureDetector(
          onTap: () => onTapAction(context),
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.expand_less,
                      color: Colors.white70,
                    ),
                    NextSong(
                      queue: queue,
                      index: index,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
