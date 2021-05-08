import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../theming.dart';
import '../utils.dart';

class AlbumBackground extends StatelessWidget {
  const AlbumBackground({Key key, this.child, this.song}) : super(key: key);

  final Widget child;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 96.0, sigmaY: 96.0),
      child: ShaderMask(
        shaderCallback: (Rect bounds) => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            DARK3.withOpacity(0.2),
            DARK3.withOpacity(0.2),
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor,
          ],
          stops: const [
            0.0,
            0.2,
            0.6,
            0.75,
            1.0,
          ],
        ).createShader(bounds),
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
