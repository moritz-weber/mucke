import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';

class NextSong extends StatelessWidget {
  const NextSong({Key key, this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          color: Colors.white70,
        ),
        children: [
          TextSpan(text: '${song.title}'),
          const TextSpan(text: ' • '),
          TextSpan(
            text: '${song.artist}',
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
