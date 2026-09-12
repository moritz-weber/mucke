import 'dart:convert';

import '../../domain/entities/synced_lyrics.dart';

/// Model for [SyncedLyrics] that adds creation and serialization logic.
class SyncedLyricsModel extends SyncedLyrics {
  const SyncedLyricsModel({
    required super.lines,
    super.offset,
  });

  /// Parses LRC text into a [SyncedLyricsModel].
  ///
  /// Returns `null` if the input contains no timestamped lines.
  static SyncedLyricsModel? fromLrc(String lrc) {
    final lines = <LyricsLine>[];
    Duration? offset;
    var hasTimestampedLine = false;

    for (final rawLine in lrc.split('\n')) {
      final line = rawLine.trimRight();
      if (line.isEmpty) continue;

      final timestamps = <Duration>[];
      var rest = line;
      final timestampPattern = RegExp(r'\[(\d{1,3}):(\d{1,2})(?:\.(\d{1,3}))?\]');
      while (true) {
        final match = timestampPattern.firstMatch(rest);
        if (match == null) break;
        timestamps.add(_parseTimestamp(match));
        rest = rest.substring(match.end);
      }

      if (timestamps.isNotEmpty) {
        // A synced line. Multiple timestamps on one line duplicate the text.
        hasTimestampedLine = true;
        for (final timestamp in timestamps) {
          lines.add(LyricsLine(timestamp: timestamp, text: rest.trim()));
        }
        continue;
      }

      // No timestamp: check for a metadata tag like [offset:+500].
      final tagMatch = RegExp(r'^\[(\w+):(.*)\]$').firstMatch(line);
      if (tagMatch != null) {
        final key = tagMatch.group(1);
        final value = tagMatch.group(2);
        if (key == 'offset') {
          final parsed = int.tryParse(value ?? '');
          if (parsed != null) {
            offset = Duration(milliseconds: parsed);
          }
        }
        // Other tags (ti, ar, al, by, ...) are ignored.
        continue;
      }

      // A plain text line without a timestamp. Preserve it at the timestamp of
      // the previous line, or at 0 if there is no previous line.
      final timestamp = lines.isEmpty
          ? Duration.zero
          : lines.last.timestamp;
      lines.add(LyricsLine(timestamp: timestamp, text: line.trim()));
    }

    // Only treat as synced if there was at least one timestamped line.
    if (!hasTimestampedLine) {
      return null;
    }

    // Apply the global offset and clamp at >= 0.
    if (offset != null) {
      for (var i = 0; i < lines.length; i++) {
        final adjusted = lines[i].timestamp + offset;
        lines[i] = LyricsLine(
          timestamp: adjusted < Duration.zero ? Duration.zero : adjusted,
          text: lines[i].text,
        );
      }
    }

    // Sort by timestamp, keeping the original order for equal timestamps.
    lines.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return SyncedLyricsModel(lines: lines, offset: offset);
  }

  static Duration _parseTimestamp(Match match) {
    final minutes = int.parse(match.group(1)!);
    final seconds = int.parse(match.group(2)!);
    final fraction = match.group(3);
    var milliseconds = 0;
    if (fraction != null) {
      // Pad/truncate the fraction to 3 digits (milliseconds).
      final padded = fraction.padRight(3, '0');
      milliseconds = int.parse(padded.substring(0, 3));
    }
    return Duration(
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }

  /// Serializes this [SyncedLyricsModel] to a JSON string for storage.
  String toJson() {
    return jsonEncode({
      'offset': offset?.inMilliseconds,
      'lines': [
        for (final line in lines)
          {'t': line.timestamp.inMilliseconds, 'x': line.text},
      ],
    });
  }

  /// Deserializes a [SyncedLyricsModel] from the JSON produced by [toJson].
  /// Returns `null` if [json] is null or cannot be parsed.
  static SyncedLyricsModel? fromJson(String? json) {
    if (json == null || json.isEmpty) return null;
    try {
      final data = jsonDecode(json) as Map;
      final offsetMs = data['offset'] as int?;
      final rawLines = data['lines'] as List;
      final lines = <LyricsLine>[];
      for (final raw in rawLines) {
        final entry = raw as Map;
        lines.add(LyricsLine(
          timestamp: Duration(milliseconds: entry['t'] as int),
          text: entry['x'] as String,
        ));
      }
      return SyncedLyricsModel(
        lines: lines,
        offset: offsetMs == null ? null : Duration(milliseconds: offsetMs),
      );
    } catch (_) {
      return null;
    }
  }
}