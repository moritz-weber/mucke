import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/presentation/widgets/album_art.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';

class AlbumArtSwipe extends StatefulWidget {
  const AlbumArtSwipe({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _AlbumArtSwipeState createState() => _AlbumArtSwipeState(child: child);
}

class _AlbumArtSwipeState extends State<AlbumArtSwipe> {
  _AlbumArtSwipeState({required this.child}) : super();

  Widget child;
  bool startToEnd = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
                  begin: Offset(startToEnd ? -1 : 1, 0),
                  end: const Offset(0, 0))
              .animate(animation),
          child: child,
        );
      },
      child: Dismissible(
        key: UniqueKey(),
        resizeDuration: null,
        onDismissed: _onHorizontalSwipe,
        direction: DismissDirection.horizontal,
        child: child,
      ),
    );
  }

  static final AudioStore audioStore = GetIt.I<AudioStore>();
  void _onHorizontalSwipe(DismissDirection direction) {
    final int? queueIndex = audioStore.queueIndexStream.value;
    if (queueIndex == null) return;

    if (direction == DismissDirection.startToEnd && audioStore.hasPrevious) {
      audioStore.skipToPrevious();
      final Song? song = audioStore.queue[queueIndex - 1].song;
      if (song == null) return;
      setState(() {
        child = AlbumArt(song: song);
        startToEnd = true;
      });
    } else if (audioStore.hasNext) {
      audioStore.skipToNext();
      final Song? song = audioStore.queue[queueIndex + 1].song;
      if (song == null) return;
      setState(() {
        child = AlbumArt(song: song);
        startToEnd = false;
      });
    }
  }
}
