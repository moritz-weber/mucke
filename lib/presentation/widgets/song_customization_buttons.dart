import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../theming.dart';

class SongCustomizationButtons extends StatelessWidget {
  const SongCustomizationButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = Provider.of<MusicDataStore>(context);
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) => Row(
        children: [
          const Icon(
            Icons.link,
            size: 20.0,
          ),
          Container(
            width: 40,
          ),
          const Icon(
            Icons.favorite,
            size: 20.0,
            color: RASPBERRY,
          ),
          Container(
            width: 40,
          ),
          IconButton(
            icon: Icon(
              Icons.remove_circle_outline,
              size: 20.0,
              color: audioStore.song.blocked ? Colors.red : Colors.white70,
            ),
            onPressed: () => musicDataStore.setSongBlocked(audioStore.song, !audioStore.song.blocked),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
