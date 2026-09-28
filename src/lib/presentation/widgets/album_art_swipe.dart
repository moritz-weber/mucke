import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/audio_player_state.dart';
import '../../domain/entities/queue_item.dart';
import '../state/audio_store.dart';
import 'album_art.dart';
import 'lyrics_view_blurred.dart';
import 'synced_lyrics_view_blurred.dart';

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

  late ReactionDisposer _stateReaction;
  late List<QueueItem> _queue;

  // the path of the song currently displayed by the PageView
  // used to detect whether an index change actually corresponds to a song change
  // (e.g. when reshuffling, the index may change while the current song stays the same)
  String? _currentSongPath;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: audioStore.currentIndex ?? 0);

    _queue = audioStore.state.queue;
    _currentSongPath = audioStore.currentSong?.path;

    _stateReaction = reaction<AudioPlayerState>(
      (_) => audioStore.state,
      _onState,
    );
  }

  void _onState(AudioPlayerState state) {
    final value = state.currentIndex;
    if (value == null || value < 0 || value >= state.queue.length) return;

    setState(() {
      _queue = state.queue;
    });

    final songPath = state.queue[value].song.path;
    final songChanged = songPath != _currentSongPath;
    _currentSongPath = songPath;

    // only animate if not already on the same page (rounded)
    if (controller.positions.isEmpty) return;

    if (!songChanged) {
      // the song stays the same (e.g. when reshuffling), but the index
      // changed -> update the page without animating
      seekingCount++;
      controller.jumpToPage(value);
      seekingCount--;
      return;
    }

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

  @override
  void dispose() {
    controller.dispose();
    _stateReaction();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Key key = ValueKey('ALBUM_ART_SWIPE');

    return PageView.builder(
      key: key,
      controller: controller,
      clipBehavior: Clip.none,
      itemCount: _queue.length,
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
                      Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: AlbumArt(song: song),
                      ),
                      if (song.hasPlainLyrics && showLyrics)
                        song.hasSyncedLyrics
                            ? SyncedLyricsViewBlurred(
                                key: ValueKey('SYNCED_LYRICS_${song.path}'),
                                song: song,
                              )
                            : LyricsViewBlurred(song: song),
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
    if (isSeekActive && index != audioStore.currentIndex) {
      audioStore.seekToIndex(index);
    }
  }
}
