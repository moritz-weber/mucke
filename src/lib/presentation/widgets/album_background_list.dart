import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/presentation/widgets/album_background.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';

class AlbumBackgroundList extends StatefulWidget {
  const AlbumBackgroundList({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _AlbumBackgroundListState createState() =>
      _AlbumBackgroundListState(child: child);
}

class _AlbumBackgroundListState extends State<AlbumBackgroundList> {
  _AlbumBackgroundListState({required this.child}) : super();

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
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
      ),
    );
  }

  static final AudioStore audioStore = GetIt.I<AudioStore>();
  void _onHorizontalSwipe(DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      audioStore.skipToNext();
      final Song? song = audioStore.currentSongStream.value;
      if (song == null) return;
      setState(() {
        child = AlbumBackground(song: song);
      });
    } else {
      audioStore.skipToPrevious();
      final Song? song = audioStore.currentSongStream.value;
      if (song == null) return;
      setState(() {
        child = AlbumBackground(song: song);
      });
    }
  }
}
