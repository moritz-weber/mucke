import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../theming.dart';
import '../widgets/album_art.dart';
import '../widgets/play_pause_button.dart';
import '../widgets/queue_card.dart';
import '../widgets/time_progress_indicator.dart';

class CurrentlyPlayingPage extends StatelessWidget {
  const CurrentlyPlayingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('CurrentlyPlayingPage.build');
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              Observer(
            builder: (BuildContext context) {
              print('CurrentlyPlayingPage.build -> Observer.build');
              final Song song = audioStore.song;

              return Stack(
                children: <Widget>[
                  Padding(
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
                              icon: Icon(Icons.expand_more),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.more_vert),
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
                        Row(
                          children: [
                            Icon(
                              Icons.link,
                              size: 20.0,
                            ),
                            Container(
                              width: 40,
                            ),
                            Icon(
                              Icons.favorite,
                              size: 20.0,
                              color: RASPBERRY,
                            ),
                            Container(
                              width: 40,
                            ),
                            Icon(
                              Icons.remove_circle_outline,
                              size: 20.0,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        TimeProgressIndicator(),
                        const Spacer(
                          flex: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Icon(Icons.repeat, size: 20.0),
                              Icon(Icons.skip_previous, size: 32.0),
                              const PlayPauseButton(
                                circle: true,
                                iconSize: 52.0,
                              ),
                              Icon(Icons.skip_next, size: 32.0),
                              Icon(Icons.shuffle, size: 20.0),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        Container(
                          height: 64,
                        ),
                      ],
                    ),
                  ),
                  QueueCard(
                    boxConstraints: constraints,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
