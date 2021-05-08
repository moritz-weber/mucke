import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../theming.dart';
import '../widgets/album_art.dart';
import '../widgets/album_background.dart';
import '../widgets/currently_playing_header.dart';
import '../widgets/playback_control.dart';
import '../widgets/song_customization_buttons.dart';
import '../widgets/time_progress_indicator.dart';
import 'queue_page.dart';

class CurrentlyPlayingPage extends StatelessWidget {
  const CurrentlyPlayingPage({Key key}) : super(key: key);

  static final _log = Logger('CurrentlyPlayingPage');

  @override
  Widget build(BuildContext context) {
    _log.info('build started');
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragEnd: (dragEndDetails) {
            if (dragEndDetails.primaryVelocity < 0) {
              _openQueue(context);
            } else if (dragEndDetails.primaryVelocity > 0) {
              Navigator.pop(context);
            }
          },
          child: Observer(
            builder: (BuildContext context) {
              _log.info('Observer.build');
              final Song song = audioStore.currentSongStream.value;

              return Stack(
                children: [
                  AlbumBackground(
                    song: song,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CurrentlyPlayingHeader(onTap: _openQueue),
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
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  song.title,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  maxLines: 1,
                                  style: TEXT_BIG.copyWith(),
                                ),
                                Text(
                                  song.artist,
                                  style: TEXT_SUBTITLE.copyWith(
                                    color: Colors.grey[100],
                                  ),
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
}
