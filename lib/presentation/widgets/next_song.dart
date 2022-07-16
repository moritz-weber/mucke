import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';

class NextSong extends StatelessWidget {
  const NextSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      final audioStore = GetIt.I<AudioStore>();

      final List<Song> queue = audioStore.queue.map((e) => e.song).toList();
      final int? index = audioStore.queueIndexStream.value;

      if (index != null && index < queue.length - 1) {
        final Song song = queue[index + 1];
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white70,
              fontWeight: FontWeight.w200,
            ),
            children: [
              TextSpan(
                text: '${song.title}',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
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
    });
  }
}
