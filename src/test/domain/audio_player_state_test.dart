import 'package:flutter_test/flutter_test.dart';
import 'package:mucke/domain/entities/audio_player_state.dart';
import 'package:mucke/domain/entities/loop_mode.dart';
import 'package:mucke/domain/entities/queue_item.dart';
import 'package:mucke/domain/entities/shuffle_mode.dart';

import '../test_songs.dart';

void main() {
  test('derives the current queue item and song from one snapshot', () {
    final queue = [
      QueueItem(song1, originalIndex: 0, isAvailable: true),
      QueueItem(song2, originalIndex: 1, isAvailable: true),
    ];

    final state = AudioPlayerState(
      queue: queue,
      currentIndex: 1,
      shuffleMode: ShuffleMode.none,
      loopMode: LoopMode.off,
      playable: null,
      revision: 1,
    );

    expect(state.currentQueueItem, queue[1]);
    expect(state.currentSong, song2);
  });

  test('invalid indices do not expose a torn current song', () {
    final state = AudioPlayerState(
      queue: [QueueItem(song1, originalIndex: 0, isAvailable: true)],
      currentIndex: 1,
      shuffleMode: ShuffleMode.none,
      loopMode: LoopMode.off,
      playable: null,
      revision: 1,
    );

    expect(state.currentQueueItem, isNull);
    expect(state.currentSong, isNull);
  });

  test('revision does not affect structural equality', () {
    final queue = [QueueItem(song1, originalIndex: 0, isAvailable: true)];
    AudioPlayerState state(int revision) => AudioPlayerState(
          queue: queue,
          currentIndex: 0,
          shuffleMode: ShuffleMode.none,
          loopMode: LoopMode.off,
          playable: null,
          revision: revision,
        );

    expect(state(1), state(2));
  });
}