import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  int _lastActiveIndex = -1;

  /// Whether the view automatically scrolls to the active line. Disabled once
  /// the user scrolls manually; re-enabled via the lock button.
  bool _followEnabled = true;

  /// Whether the lock button is shown. It appears as soon as the user scrolls
  /// manually and reflects the current [_followEnabled] state. After
  /// re-enabling auto-scroll it fades out again.
  bool _buttonVisible = false;

  Timer? _buttonHideTimer;

  SyncedLyrics get _synced => widget.song.syncedLyrics!;

  @override
  void dispose() {
    _buttonHideTimer?.cancel();
    super.dispose();
  }

  /// Scrolls the active line to (roughly) the vertical center of the view.
  ///
  /// Uses the item index rather than a computed pixel offset so that lines of
  /// any height (including wrapped multi-line entries) scroll correctly.
  void _autoScroll(int activeIndex) {
    if (!_itemScrollController.isAttached) return;
    _itemScrollController.scrollTo(
      index: activeIndex,
      alignment: 0.5,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Scrolls back to the currently active line and re-enables auto-scroll.
  /// Hides the lock button again after a short delay.
  void _jumpToActive() {
    final Duration position = audioStore.currentPositionStream.value ?? Duration.zero;
    final int activeIndex = _synced.activeLineIndex(position);
    setState(() {
      _followEnabled = true;
    });
    if (activeIndex >= 0) _autoScroll(activeIndex);

    _buttonHideTimer?.cancel();
    _buttonHideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _buttonVisible = false;
        });
      }
    });
  }

  /// Called when the user starts dragging the lyrics list.
  bool _onScrollNotification(ScrollNotification notification) {
    // Only react to the lyrics list itself (not the enclosing PageView) and
    // only to actual user drags — ignore our own programmatic scrolls.
    if (notification.depth != 0) return false;
    if (notification is! ScrollStartNotification) return false;
    if (notification.dragDetails == null) return false;

    _buttonHideTimer?.cancel();
    if (!_buttonVisible || _followEnabled) {
      setState(() {
        _followEnabled = false;
        _buttonVisible = true;
      });
    }
    return false;
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
                  // Skip while the user is driving the scroll position.
                  if (_followEnabled) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (activeIndex >= 0) _autoScroll(activeIndex);
                    });
                  }
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: _onScrollNotification,
                  child: ScrollablePositionedList.builder(
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: _itemPositionsListener,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 28.0,
                    ),
                    itemCount: _synced.lines.length,
                    itemBuilder: (context, index) {
                      final LyricsLine line = _synced.lines[index];
                      final bool isActive = index == activeIndex;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          line.text,
                          textAlign: TextAlign.left,
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
          // Lock button: shown once the user scrolls manually. Tapping it
          // re-enables auto-scroll and jumps back to the active line.
          Positioned(
            right: 4.0,
            bottom: 4.0,
            child: IgnorePointer(
              ignoring: !_buttonVisible,
              child: AnimatedOpacity(
                opacity: _buttonVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                child: IconButton(
                  onPressed: _followEnabled ? null : _jumpToActive,
                  tooltip: _followEnabled ? null : 'Scroll to current line',
                  icon: Icon(
                    _followEnabled ? Icons.lock_outline : Icons.lock_open,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}