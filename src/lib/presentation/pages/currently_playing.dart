import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../theming.dart';
import '../widgets/album_art_swipe.dart';
import '../widgets/album_background.dart';
import '../widgets/currently_playing_control.dart';
import '../widgets/currently_playing_header.dart';
import '../widgets/song_bottom_sheet.dart';
import 'queue_page.dart';

class CurrentlyPlayingPage extends StatelessWidget {
  const CurrentlyPlayingPage({Key? key}) : super(key: key);

  static final _log = FimberLog('CurrentlyPlayingPage');

  @override
  Widget build(BuildContext context) {
    _log.d('build started');
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Scaffold(
      body: Stack(
        children: [
          const AlbumBackground(),
          SafeArea(
            child: GestureDetector(
              onVerticalDragEnd: (dragEndDetails) {
                if (dragEndDetails.primaryVelocity! < 0) {
                  _openQueue(context);
                } else if (dragEndDetails.primaryVelocity! > 0) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CurrentlyPlayingHeader(
                        onTap: _openQueue,
                        onMoreTap: _openMoreMenu,
                      ),
                    ),
                    const Spacer(
                      flex: 10,
                    ),
                    const Expanded(
                      flex: 720,
                      child: Center(
                        child: AlbumArtSwipe(),
                      ),
                    ),
                    const Spacer(
                      flex: 50,
                    ),
                    Observer(
                      builder: (BuildContext context) {
                        final Song? song = audioStore.currentSongStream.value;

                        if (song == null) return Container();
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0 + 12.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 58.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextScroll(
                                  song.title,
                                  mode: TextScrollMode.endless,
                                  velocity: const Velocity(pixelsPerSecond: Offset(40, 0)),
                                  delayBefore: const Duration(milliseconds: 500),
                                  pauseBetween: const Duration(milliseconds: 2000),
                                  pauseOnBounce: const Duration(milliseconds: 1000),
                                  style: TEXT_BIG,
                                  textAlign: TextAlign.left,
                                  fadedBorder: true,
                                  fadedBorderWidth: 0.02,
                                  fadeBorderVisibility: FadeBorderVisibility.auto,
                                  intervalSpaces: 30,
                                ),
                                TextScroll(
                                  '${song.artist} • ${song.album}',
                                  mode: TextScrollMode.endless,
                                  velocity: const Velocity(pixelsPerSecond: Offset(40, 0)),
                                  delayBefore: const Duration(milliseconds: 500),
                                  pauseBetween: const Duration(milliseconds: 2000),
                                  pauseOnBounce: const Duration(milliseconds: 1000),
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.left,
                                  fadedBorder: true,
                                  fadedBorderWidth: 0.02,
                                  fadeBorderVisibility: FadeBorderVisibility.auto,
                                  intervalSpaces: 30,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const Spacer(
                      flex: 10,
                    ),
                    const CurrentlyPlayingControl(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openQueue(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
            const QueuePage(),
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

  Future<void> _openMoreMenu(BuildContext context) async {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    final song = audioStore.currentSongStream.value;
    if (song == null) return;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SongBottomSheet(
        song: song,
        enableQueueActions: false,
        enableSongCustomization: false,
        numNavPop: 2,
      ),
    );
  }
}
