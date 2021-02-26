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
        if (audioStore.currentSongStream != null) {
          final Song song = audioStore.currentSongStream.value;
          final Duration position = audioStore.currentPositionStream?.value ?? const Duration(seconds: 0);
          if (song != null) {
            return Column(
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _onTap(context),
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: getAlbumImage(song.albumArtPath),
                          height: 64.0,
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                song.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                song.artist,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white70,
                                ),
                              )
                            ],
                          ),
                        ),
                        const PlayPauseButton(
                          circle: false,
                        ),
                        const NextButton(),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: LinearProgressIndicator(
                    value: position.inMilliseconds / song.duration,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    backgroundColor: Colors.white10,
                  ),
                  height: 2,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).primaryColor, blurRadius: 1),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container(
            height: 0,
          );
        }
        return Container();
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
