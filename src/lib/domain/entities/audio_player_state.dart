import 'package:equatable/equatable.dart';

import 'loop_mode.dart';
import 'playable.dart';
import 'queue_item.dart';
import 'shuffle_mode.dart';
import 'song.dart';

/// An immutable, self-consistent snapshot of the player's **structural** state.
///
/// The rationale for this class is that individual consumers of the state
/// might need to observe multiple fields at the same time.
/// Dividing these fields into separate streams would require handling
/// potential inconsistent states (e.g. a new index with an old queue).
///
/// High-frequency **transport** state (position, playing) is deliberately not
/// part of this snapshot as it updates too often.
class AudioPlayerState extends Equatable {
  const AudioPlayerState({
    required this.queue,
    required this.currentIndex,
    required this.shuffleMode,
    required this.loopMode,
    required this.playable,
    required this.revision,
  });

  /// The state before any queue has been loaded.
  factory AudioPlayerState.initial() => const AudioPlayerState(
        queue: <QueueItem>[],
        currentIndex: null,
        shuffleMode: ShuffleMode.none,
        loopMode: LoopMode.off,
        playable: null,
        revision: 0,
      );

  /// The current queue, in the order it will be played.
  ///
  /// This is the same list the [ManagedQueueInfo] exposes, so consumers that
  /// need queue metadata (e.g. [QueueItem.source]) can read it from the
  /// snapshot instead of subscribing to a second stream.
  final List<QueueItem> queue;

  /// The index of [currentSong] within [queue], or `null` when nothing is loaded.
  final int? currentIndex;

  final ShuffleMode shuffleMode;
  final LoopMode loopMode;

  /// The playable (album, playlist, ...) the current queue originates from, if any.
  final Playable? playable;

  /// The queue item currently being played, or `null` when nothing is loaded.
  QueueItem? get currentQueueItem =>
      (currentIndex != null && currentIndex! >= 0 && currentIndex! < queue.length)
          ? queue[currentIndex!]
          : null;

  /// The song currently being played, or `null` when nothing is loaded.
  Song? get currentSong => currentQueueItem?.song;

  /// A monotonic token identifying the transition that produced this snapshot.
  ///
  /// It is intentionally not part of [props]: equality is content-based so
  /// that `.distinct()` on the snapshot stream dedupes snapshots that carry no
  /// actual change. [revision] is available for consumers that need a cheap
  /// "did a new transition happen" check.
  final int revision;

  @override
  List<Object?> get props => [
        queue,
        currentIndex,
        shuffleMode,
        loopMode,
        playable,
      ];

  @override
  String toString() =>
      'AudioPlayerState(rev: $revision, index: $currentIndex, '
      'song: ${currentSong?.title}, queue: ${queue.length}, '
      'shuffle: $shuffleMode, loop: $loopMode)';
}
