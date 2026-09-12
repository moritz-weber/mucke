import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../utils.dart';

/// Displays the lyrics of a song as an overlay on top of the album artwork.
/// The album art behind is blurred and a dark transparent overlay is added on
/// top for contrast. This widget is meant to be stacked on top of an
/// [AlbumArt] widget, which provides the actual artwork.
class LyricsViewBlurred extends StatefulWidget {
  const LyricsViewBlurred({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  State<LyricsViewBlurred> createState() => _LyricsViewBlurredState();
}

class _LyricsViewBlurredState extends State<LyricsViewBlurred> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? lyrics = widget.song.plainLyrics;
    if (lyrics == null || lyrics.isEmpty) {
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
            child: Container(color: bgColor(widget.song.color).withValues(alpha: 0.5)),
          ),
          // Lyrics on top
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              thickness: 3.0,
              radius: const Radius.circular(1.5),
              child: SingleChildScrollView(
                controller: _scrollController,
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 28.0,
                ),
                child: Text(
                  lyrics,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
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
