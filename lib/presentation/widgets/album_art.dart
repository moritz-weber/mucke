import 'package:flutter/material.dart';
import 'package:mucke/presentation/theming.dart';

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
        elevation: 6.0,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image(
                image: getAlbumImage(song.albumArtPath),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 140,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00000000),
                        Color(0xCC000000)
                      ],
                      stops: [
                        0.0,
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
                      style: TEXT_BIG,
                    ),
                    Text(
                      song.artist,
                      style: TEXT_SUBTITLE.copyWith(color: Colors.white70),
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
