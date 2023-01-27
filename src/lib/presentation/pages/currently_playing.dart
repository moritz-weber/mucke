import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

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
          GestureDetector(
            onVerticalDragEnd: (dragEndDetails) {
              if (dragEndDetails.primaryVelocity! < 0) {
                _openQueue(context);
              } else if (dragEndDetails.primaryVelocity! > 0) {
                Navigator.pop(context);
              }
            },
            child: const AlbumBackground(),
          ),
          SafeArea(
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
                              maxLines: 2,
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
        ],
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
