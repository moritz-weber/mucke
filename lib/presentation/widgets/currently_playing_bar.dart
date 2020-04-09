import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/song.dart';
import '../pages/currently_playing.dart';
import '../state/audio_store.dart';
import '../utils.dart';

class CurrentlyPlayingBar extends StatelessWidget {
  const CurrentlyPlayingBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        if (audioStore.currentSong.value != null) {
          final Song song = audioStore.currentSong.value;

          return Column(
            children: <Widget>[
              Container(
                child: const LinearProgressIndicator(
                  value: 0.42,
                ),
                height: 2,
              ),
              GestureDetector(
                onTap: () => _onTap(context),
                child: Row(
                  children: <Widget>[
                    Image(
                      image: getAlbumImage(song.albumArtPath),
                      height: 64.0,
                    ),
                    Container(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(song.title),
                        Text(
                          song.artist,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white70,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Container(
          height: 0,
        );
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
