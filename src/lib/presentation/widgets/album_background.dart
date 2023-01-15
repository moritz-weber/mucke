import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../theming.dart';
import '../utils.dart';

class AlbumBackground extends StatefulWidget {
  const AlbumBackground({Key? key}) : super(key: key);

  @override
  State<AlbumBackground> createState() => _AlbumBackgroundState();
}

class _AlbumBackgroundState extends State<AlbumBackground> {
  final AudioStore audioStore = GetIt.I<AudioStore>();
  late Widget _backgroundWidget;
  late StreamSubscription<Song?> _streamSub;

  @override
  void initState() {
    super.initState();

    setState(() {
      _backgroundWidget = _getBackgroundWidget(audioStore.currentSongStream.value);
    });

    _streamSub = audioStore.currentSongStream.listen((value) {
      setState(() {
        _backgroundWidget = _getBackgroundWidget(value);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSub.cancel();
  }

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
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: _backgroundWidget,
        ),
      ),
    );
  }

  Widget _getBackgroundWidget(Song? song) {
    if (song == null) return Container(color: DARK3);

    return Container(
      key: ValueKey(song.albumArtPath),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: getAlbumImage(song.albumArtPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
