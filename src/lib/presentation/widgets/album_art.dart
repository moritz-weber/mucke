import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../utils.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 1)),
          ],
        ),
        child: Image(
          image: getAlbumImage(song.albumArtPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
