import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import 'like_button.dart';

class SongCustomizationButtons extends StatelessWidget {
  const SongCustomizationButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = Provider.of<MusicDataStore>(context);
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        final Song song = audioStore.currentSongStream.value;
        return Container(
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  song.next == null ? Icons.link_off : Icons.link,
                  color: song.next == null ? Colors.white24 : Colors.white,
                ),
                iconSize: 20.0,
                onPressed: () => musicDataStore.toggleNextSongLink(song),
                visualDensity: VisualDensity.compact,
              ),
              const LikeButton(
                iconSize: 20.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.remove_circle_outline_rounded,
                  size: 20.0,
                  color: song.blocked ? Colors.white : Colors.white24,
                ),
                onPressed: () => musicDataStore.setSongBlocked(song, !song.blocked),
                visualDensity: VisualDensity.compact,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        );
      },
    );
  }
}
