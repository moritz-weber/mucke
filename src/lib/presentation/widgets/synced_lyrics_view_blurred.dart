import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../../domain/entities/synced_lyrics.dart';
import '../state/audio_store.dart';
import '../utils.dart';

/// Displays synced lyrics of a song as an overlay on top of the album artwork,
/// highlighting the currently active line and auto-scrolling to it.
///
/// This is a first prototype: the line list is rebuilt on every position
/// update and auto-scroll is not throttled against manual scrolling.
class SyncedLyricsViewBlurred extends StatefulWidget {
  const SyncedLyricsViewBlurred({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  State<SyncedLyricsViewBlurred> createState() => _SyncedLyricsViewBlurredState();
}

class _SyncedLyricsViewBlurredState extends State<SyncedLyricsViewBlurred> {
  final AudioStore audioStore = GetIt.I<AudioStore>();
  final ScrollController _scrollController = ScrollController();

  int _lastActiveIndex = -1;

  static const double _lineHeight = 30.0;

  SyncedLyrics get _synced => widget.song.syncedLyrics!;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Scrolls the active line to (roughly) the vertical center of the view.
  void _autoScroll(int activeIndex) {
    if (!_scrollController.hasClients) return;
    // Approximate offset using a fixed line height. Good enough for a prototype.
    final target = (activeIndex * _lineHeight) -
        (_scrollController.position.viewportDimension / 2) +
        (_lineHeight / 2);
    _scrollController.animateTo(
      target.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Song song = widget.song;
    if (!song.hasSyncedLyrics) {
      return const SizedBox.shrink();
    }

    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Blur effect over the album art behind
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 64, sigmaY: 64),
            child: Container(color: bgColor(song.color).withValues(alpha: 0.5)),
          ),
          // Lyrics on top
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Observer(
              builder: (BuildContext context) {
                final Duration position =
                    audioStore.currentPositionStream.value ?? Duration.zero;
                final int activeIndex = _synced.activeLineIndex(position);

                if (activeIndex != _lastActiveIndex) {
                  _lastActiveIndex = activeIndex;
                  // Schedule after this frame, once the list has laid out.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (activeIndex >= 0) _autoScroll(activeIndex);
                  });
                }

                return Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  thickness: 3.0,
                  radius: const Radius.circular(1.5),
                  child: ListView.builder(
                    controller: _scrollController,
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 40.0,
                    ),
                    itemCount: _synced.lines.length,
                    itemExtent: _lineHeight,
                    itemBuilder: (context, index) {
                      final LyricsLine line = _synced.lines[index];
                      final bool isActive = index == activeIndex;
                      return Center(
                        child: Text(
                          line.text,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.white54,
                            fontSize: isActive ? 20.0 : 18.0,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}