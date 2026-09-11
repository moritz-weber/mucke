import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../theming.dart';
import '../utils.dart';

/// Displays the lyrics of a song in place of the album artwork, with the
/// song's album art shown blurred in the background and a dark transparent
/// overlay on top for contrast.
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
    final String? lyrics = widget.song.lyrics;
    if (lyrics == null || lyrics.isEmpty) {
      return const SizedBox.shrink();
    }

    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Blurred album art background
              Image(
                image: getAlbumImage(widget.song.albumArtPath),
                fit: BoxFit.cover,
              ),
              // Blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 64, sigmaY: 64),
                child: Container(color: Colors.transparent),
              ),
              // Dark transparent overlay for contrast
              Container(color: bgColor(widget.song.color).withValues(alpha: 0.5)),
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
                    padding: const EdgeInsets.all(14.0),
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
        ),
      ),
    );
  }
}
