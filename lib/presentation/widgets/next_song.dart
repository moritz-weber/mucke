import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';

class NextSong extends StatelessWidget {
  const NextSong({Key key, this.queue, this.index}) : super(key: key);

  final List<Song> queue;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (index < queue.length - 1) {
      final Song song = queue[index + 1];
      return RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
          children: [
            TextSpan(text: '${song.title}'),
            const TextSpan(text: ' • '),
            TextSpan(
              text: '${song.artist}',
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 16.0,
      );
    }
  }
}
