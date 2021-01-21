import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../utils.dart';

class AlbumBackground extends StatelessWidget {
  const AlbumBackground({Key key, this.child, this.song, this.gradient}) : super(key: key);

  final Widget child;
  final Song song;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 96.0, sigmaY: 96.0),
      child: ShaderMask(
        shaderCallback: (Rect bounds) => gradient.createShader(bounds),
        blendMode: BlendMode.srcATop,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: getAlbumImage(song.albumArtPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
