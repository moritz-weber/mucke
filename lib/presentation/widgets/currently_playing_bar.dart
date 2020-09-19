import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/song.dart';
import '../pages/currently_playing.dart';
import '../state/audio_store.dart';
import '../utils.dart';
import 'next_button.dart';
import 'play_pause_button.dart';

class CurrentlyPlayingBar extends StatelessWidget {
  const CurrentlyPlayingBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        if (audioStore.currentSongStream.value != null) {
          final Song song = audioStore.currentSongStream.value;

          return Column(
            children: <Widget>[
              Container(
                child: LinearProgressIndicator(
                  value: audioStore.currentPositionStream.value / audioStore.currentSongStream.value.duration,
                ),
                height: 2,
              ),
              GestureDetector(
                onTap: () => _onTap(context),
                child: Row(
                  children: <Widget>[
                    Image(
                      image: getAlbumImage(song.albumArtPath),
                      height: 64.0,
                    ),
                    Container(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(song.title),
                        Text(
                          song.artist,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white70,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    const PlayPauseButton(
                      circle: false,
                    ),
                    const NextButton(),
                  ],
                ),
              ),
            ],
          );
        }
        return Container(
          height: 0,
        );
      },
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => const CurrentlyPlayingPage(),
      ),
    );
  }
}
