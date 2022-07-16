import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../theming.dart';
import '../widgets/album_art.dart';
import '../widgets/album_background.dart';
import '../widgets/currently_playing_header.dart';
import '../widgets/playback_control.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_customization_buttons.dart';
import '../widgets/time_progress_indicator.dart';
import 'queue_page.dart';

class CurrentlyPlayingPage extends StatelessWidget {
  const CurrentlyPlayingPage({Key? key}) : super(key: key);

  static final _log = FimberLog('CurrentlyPlayingPage');

  @override
  Widget build(BuildContext context) {
    _log.d('build started');
    final AudioStore audioStore = GetIt.I<AudioStore>();

    // TODO: everything wrapped in Observer and most components have Observer themselves
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragEnd: (dragEndDetails) {
            if (dragEndDetails.primaryVelocity! < 0) {
              _openQueue(context);
            } else if (dragEndDetails.primaryVelocity! > 0) {
              Navigator.pop(context);
            }
          },
          child: Observer(
            builder: (BuildContext context) {
              _log.d('Observer.build');
              final Song? song = audioStore.currentSongStream.value;
              if (song == null) return Container();

              return Stack(
                children: [
                  AlbumBackground(
                    song: song,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CurrentlyPlayingHeader(
                          onTap: _openQueue,
                          onMoreTap: _openMoreMenu,
                        ),
                        const Spacer(
                          flex: 10,
                        ),
                        Expanded(
                          flex: 720,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 0.0,
                              ),
                              child: AlbumArt(
                                song: song,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 74.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.title,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  maxLines: 1,
                                  style: TEXT_BIG,
                                ),
                                Text(
                                  '${song.artist} • ${song.album}',
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w300,
                                  ),

                                  // TEXT_SUBTITLE.copyWith(
                                  // ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 6.0, right: 6.0),
                          child: SongCustomizationButtons(),
                        ),
                        const Spacer(
                          flex: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: PlaybackControl(),
                        ),
                        const Spacer(
                          flex: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                          child: TimeProgressIndicator(),
                        ),
                        const Spacer(
                          flex: 60,
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Icon(
                              Icons.expand_less,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _openQueue(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => const QueuePage(),
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
