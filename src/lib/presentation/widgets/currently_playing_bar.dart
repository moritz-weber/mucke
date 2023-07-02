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

    return Column(
      verticalDirection: VerticalDirection.up,
      children: <Widget>[
        GestureDetector(
          onTap: () => _onTap(context),
          child: Material(
            color: DARK1,
            child: Observer(builder: (context) {
              final Song? song = audioStore.currentSongStream.value;
              if (song == null) return Container();

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
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
                            maxLines: 1,
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
                  ],
                ),
              );
            }),
          ),
        ),
        Container(
          child: Observer(
            builder: (context) {
              final Song? song = audioStore.currentSongStream.value;
              if (song == null) return Container();
              final Duration position =
                  audioStore.currentPositionStream.value ?? const Duration(seconds: 0);
              return LinearProgressIndicator(
                value: position.inMilliseconds / song.duration.inMilliseconds,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: Colors.white10,
              );
            },
          ),
          height: 2,
        ),
      ],
    );
  }

Future<void> _onTap(BuildContext context) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
            const CurrentlyPlayingPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
      ),
    );
  }
}
