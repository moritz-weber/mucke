import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../utils.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt({Key key, this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Stack(
          children: [
            Image(
              image: getAlbumImage(song.albumArtPath),
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: const [
                        Color(0x00555555),
                        Color(0x77333333),
                        Color(0xCC111111),
                        Color(0xEE000000)
                      ],
                      stops: const [
                        0.0,
                        0.6,
                        0.8,
                        1.0
                      ]),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      song.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      height: 4.0,
                    ),
                    Text(
                      song.artist,
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      song.album,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
