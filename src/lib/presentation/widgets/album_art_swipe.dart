import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/queue_item.dart';
import '../state/audio_store.dart';
import 'album_art.dart';
import 'lyrics_view_blurred.dart';

class AlbumArtSwipe extends StatefulWidget {
  const AlbumArtSwipe({Key? key}) : super(key: key);

  @override
  State<AlbumArtSwipe> createState() => _AlbumArtSwipeState();
}

class _AlbumArtSwipeState extends State<AlbumArtSwipe> {
  final AudioStore audioStore = GetIt.I<AudioStore>();
  late PageController controller;
  // a count > 0 means that an animation is to be performed due to index changes
  // thus, the PageView should not trigger any new seekToIndex executions during this time
  // when this widget is not in focues (e.g. when the queue page is active), scheduled animations get aborted
  // scheduling a new animation, increases this count; finishing/aborting decreases it
  int seekingCount = 0;
  bool get isSeekActive => seekingCount <= 0;

  late StreamSubscription _indexStreamSubscription;
  late StreamSubscription _queueStreamSubscription;
  late List<QueueItem> _queue;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: audioStore.queueIndexStream.value!);

    _queue = audioStore.queue;
    _queueStreamSubscription = audioStore.queueStream.listen((value) {
      setState(() {
        _queue = value;
      });
    });

    _indexStreamSubscription = audioStore.queueIndexStream.listen((value) {
      if (value == null) return;

      // only animate if not already on the same page (rounded)
      if (controller.positions.isNotEmpty) {
        final diff = (value - (controller.page ?? value)).abs();
        if (diff < 0.5 || diff > 1.5) {
          seekingCount++;
          controller.jumpToPage(value);
          seekingCount--;
        } else {
          seekingCount++;
          controller
              .animateToPage(
                value,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              )
              .then((_) => seekingCount--);
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _queueStreamSubscription.cancel();
    _indexStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Key key = ValueKey('ALBUM_ART_SWIPE');

    return PageView.builder(
      key: key,
      controller: controller,
      clipBehavior: Clip.none,
      itemBuilder: (_, index) {
        final song = _queue[index].song;
        return Observer(
          builder: (BuildContext context) {
            final bool showLyrics = audioStore.showLyrics;
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.0),
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      AlbumArt(song: song),
                      if (song.hasLyrics && showLyrics) LyricsViewBlurred(song: song),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      onPageChanged: _conditionalSeek,
    );
  }

  void _conditionalSeek(int index) {
    if (isSeekActive && index != audioStore.queueIndexStream.value) {
      audioStore.seekToIndex(index);
    }
  }
}
