import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/presentation/widgets/album_art.dart';

import '../state/audio_store.dart';

class AlbumArtSwipe extends StatefulWidget {
  const AlbumArtSwipe({Key? key, required this.queueIndex}) : super(key: key);

  final int queueIndex;

  @override
  _AlbumArtSwipeState createState() => _AlbumArtSwipeState(queueIndex: queueIndex);
}

class _AlbumArtSwipeState extends State<AlbumArtSwipe> {
  _AlbumArtSwipeState({required this.queueIndex}) : super();
  static final _log = FimberLog('AlbumArtSwipe');

  int queueIndex;
  late PageController controller;
  static final AudioStore audioStore = GetIt.I<AudioStore>();

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: audioStore.queueIndexStream.value!);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = PageController(initialPage: queueIndex);
    return PageView.builder(
      controller: controller,
      itemCount: audioStore.queueLength,
      itemBuilder: (_, index) {
        return AlbumArt(song: audioStore.queue[index].song);
      },
      onPageChanged: (value) {
        audioStore.seekToIndex(value);
      },
    );
  }
}
