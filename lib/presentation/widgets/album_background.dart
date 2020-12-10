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
      child: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x55000000),
              Color(0x22FFFFFF),
              Color(0x22FFFFFF),
              Color(0x88000000),
              Color(0xBB000000),
            ],
            stops: [
              0.0,
              0.1,
              0.5,
              0.65,
              1.0,
            ],
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 96.0, sigmaY: 96.0),
          child: Container(
            child: child,
            color: Colors.white.withOpacity(0.0),
          ),
        ),
      ),
    );
  }
}
