import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:palette_generator/palette_generator.dart';

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
  Widget _backgroundWidget = Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [DARK3, DARK1],
      stops: [0.0, 1.0],
    )),
  );
  late StreamSubscription<Song?> _streamSub;

  @override
  void initState() {
    super.initState();

    _setBackgroundWidget(audioStore.currentSongStream.value);

    _streamSub = audioStore.currentSongStream.listen(_setBackgroundWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _streamSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: _backgroundWidget,
    );
  }

  Future<void> _setBackgroundWidget(Song? song) async {
    if (song == null) return;

    PaletteGenerator.fromImageProvider(
      getAlbumImage(song.albumArtPath),
      targets: PaletteTarget.baseTargets,
    ).then((paletteGenerator) {
      final colors = <Color?>[
        paletteGenerator.vibrantColor?.color,
        paletteGenerator.lightVibrantColor?.color,
        paletteGenerator.mutedColor?.color,
        paletteGenerator.darkVibrantColor?.color,
        paletteGenerator.lightMutedColor?.color,
        paletteGenerator.dominantColor?.color,
        DARK3,
      ];

      final Color? color = colors.firstWhere((c) => c != null);

      setState(() {
        _backgroundWidget = Container(
          key: ValueKey(song.albumArtPath),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.lerp(DARK3, color, 0.4) ?? DARK3, DARK1],
              stops: const [0.0, 1.0],
            ),
          ),
        );
      });
    });
  }
}
