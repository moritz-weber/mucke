import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../widgets/album_art.dart';
import '../widgets/album_background.dart';
import '../widgets/next_indicator.dart';
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
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              Observer(
            builder: (BuildContext context) {
              _log.info('Observer.build');
              final Song song = audioStore.currentSong;

              return AlbumBackground(
                song: song,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    top: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.expand_more),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AlbumArt(
                          song: song,
                        ),
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                      const SongCustomizationButtons(),
                      const Spacer(
                        flex: 3,
                      ),
                      const TimeProgressIndicator(),
                      const Spacer(
                        flex: 3,
                      ),
                      const PlaybackControl(),
                      const Spacer(),
                      NextIndicator(
                        onTapAction: openQueue,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void openQueue(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => const QueuePage(),
      ),
    );
  }
}
