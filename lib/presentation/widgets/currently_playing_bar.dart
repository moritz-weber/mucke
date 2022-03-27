import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../pages/currently_playing.dart';
import '../state/audio_store.dart';
import '../theming.dart';
import '../utils.dart';
import 'next_button.dart';
import 'play_pause_button.dart';

class CurrentlyPlayingBar extends StatelessWidget {
  const CurrentlyPlayingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final Song? song = audioStore.currentSongStream.value;
        final Duration position =
            audioStore.currentPositionStream.value ?? const Duration(seconds: 0);
        if (song != null) {
          return Column(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              GestureDetector(
                onTap: () => _onTap(context),
                child: Container(
                  color: Colors.white.withOpacity(0.02),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0, right: 12.0),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.5),
                          ),
                          width: 56.0,
                          child: Image(
                            image: getAlbumImage(song.albumArtPath),
                            height: 56.0,
                          ),
                        ),
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
                              style: TEXT_SMALL_SUBTITLE.copyWith(color: Colors.white70),
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
                  value: position.inMilliseconds / song.duration.inMilliseconds,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  backgroundColor: Colors.white10,
                ),
                height: 2,
              ),
            ],
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
