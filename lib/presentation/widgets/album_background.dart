import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../utils.dart';

class AlbumBackground extends StatelessWidget {
  const AlbumBackground({Key key, this.child, this.song}) : super(key: key);

  final Widget child;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: getAlbumImage(song.albumArtPath),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 64.0, sigmaY: 64.0),
        child: Container(
          child: child,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}
