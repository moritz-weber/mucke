import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mucke/presentation/state/audio_store.dart';
import 'package:mucke/presentation/widgets/next_song.dart';
import 'package:provider/provider.dart';

class NextIndicator extends StatelessWidget {
  const NextIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        final queue = audioStore.queueStream.value;
        final int index = audioStore.queueIndexStream.value;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.expand_less,
                  color: Colors.white70,
                ),
                if (index < queue.length - 1) NextSong(song: queue[index + 1]),
              ],
            ),
          ),
        );
      },
    );
  }
}
