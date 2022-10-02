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
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0.0, top: 8.0),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 4.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                border: Border.all(color: DARK3, width: 0.4),
                                borderRadius: BorderRadius.circular(2.0),
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
                            key: ValueKey('CURRENTLY_PLAYING_BAR_PLAY_PAUSE'),
                            circle: false,
                          ),
                          const NextButton(
                            key: ValueKey('CURRENTLY_PLAYING_BAR_NEXT'),
                          ),
                          const SizedBox(width: 4.0),
                        ],
                      ),
                    ),
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
