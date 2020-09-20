import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/song.dart';
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
      builder: (BuildContext context) {
        final Song song = audioStore.currentSongStream.value;
        return Row(
          children: [
            const IconButton(
              icon: Icon(
                Icons.link,
                size: 20.0,
                color: Colors.white10,
              ),
              onPressed: null,
            ),
            Container(
              width: 40,
            ),
            const IconButton(
              icon: Icon(
                Icons.favorite,
                size: 20.0,
                color: Colors.white10,
              ),
              onPressed: null,
            ),
            Container(
              width: 40,
            ),
            IconButton(
              icon: Icon(
                Icons.remove_circle_outline,
                size: 20.0,
                color: song.blocked ? RASPBERRY : Colors.white70,
              ),
              onPressed: () =>
                  musicDataStore.setSongBlocked(song, !song.blocked),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
