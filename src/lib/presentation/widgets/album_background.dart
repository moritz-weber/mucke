import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

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
  late ReactionDisposer _songReaction;

  @override
  void initState() {
    super.initState();

    _setBackgroundWidget(audioStore.currentSong);

    _songReaction = reaction<Song?>(
      (_) => audioStore.currentSong,
      _setBackgroundWidget,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _songReaction();
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

    setState(() {
      _backgroundWidget = Container(
        key: ValueKey(song.albumArtPath),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bgColor(song.color), DARK1],
            stops: const [0.0, 1.0],
          ),
        ),
      );
    });
  }
}
