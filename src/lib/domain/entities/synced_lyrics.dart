import 'package:equatable/equatable.dart';

/// A single line of synced lyrics with its timestamp.
class LyricsLine extends Equatable {
  const LyricsLine({
    required this.timestamp,
    required this.text,
  });

  /// The time at which this line becomes active, in milliseconds.
  final Duration timestamp;

  /// The line content. May be empty for instrumental gaps.
  final String text;

  @override
  List<Object?> get props => [timestamp, text];

  @override
  String toString() => 'LyricsLine(timestamp: $timestamp, text: "$text")';
}

/// Parsed, synced lyrics for a single song.
///
/// Lines are sorted by timestamp. Use [activeLineIndex] to find the line that
/// is active at a given playback position.
class SyncedLyrics extends Equatable {
  const SyncedLyrics({
    required this.lines,
    this.offset,
  });

  /// The parsed lines, sorted by timestamp.
  final List<LyricsLine> lines;

  /// Optional global offset in milliseconds from the `[offset:]` tag.
  /// Already applied to the timestamps in [lines] on import.
  final Duration? offset;

  /// Whether there is at least one line.
  bool get hasLines => lines.isNotEmpty;

  @override
  List<Object?> get props => [lines, offset];

  /// Reconstructs the plain lyrics text.
  @override
  String toString() {
    final buffer = StringBuffer();
    for (final line in lines) {
      buffer.write(line.text);
      buffer.write('\n');
    }
    return buffer.toString();
  }

  /// Returns the index of the last line whose timestamp is `<= [position]`,
  /// or `-1` if [position] is before the first line.
  ///
  /// Uses binary search over the (sorted) [lines].
  int activeLineIndex(Duration position) {
    if (lines.isEmpty || position < lines.first.timestamp) {
      return -1;
    }

    var low = 0;
    var high = lines.length - 1;
    var result = 0;
    while (low <= high) {
      final mid = (low + high) ~/ 2;
      if (lines[mid].timestamp <= position) {
        result = mid;
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    return result;
  }
}