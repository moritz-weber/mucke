import 'package:flutter_test/flutter_test.dart';

import 'package:mucke/domain/entities/synced_lyrics.dart';
import 'package:mucke/system/models/synced_lyrics_model.dart';

void main() {
  group('fromLrc', () {
    test('parses basic synced lines', () {
      final sut = SyncedLyricsModel.fromLrc(
        '[00:12.34]Hello world\n[00:17.80]Next line',
      )!;

      expect(sut.lines.length, 2);
      expect(sut.lines[0].timestamp, const Duration(milliseconds: 12340));
      expect(sut.lines[0].text, 'Hello world');
      expect(sut.lines[1].timestamp, const Duration(milliseconds: 17800));
      expect(sut.lines[1].text, 'Next line');
    });

    test('parses timestamps without subseconds', () {
      final sut = SyncedLyricsModel.fromLrc('[00:12]Hello')!;

      expect(sut.lines[0].timestamp, const Duration(milliseconds: 12000));
    });

    test('parses 3-digit subsecond precision', () {
      final sut = SyncedLyricsModel.fromLrc('[00:12.345]Hello')!;

      expect(sut.lines[0].timestamp, const Duration(milliseconds: 12345));
    });

    test('parses 1-digit subsecond precision', () {
      final sut = SyncedLyricsModel.fromLrc('[00:12.3]Hello')!;

      expect(sut.lines[0].timestamp, const Duration(milliseconds: 12300));
    });

    test('parses minutes greater than 59', () {
      final sut = SyncedLyricsModel.fromLrc('[61:05.00]Long song')!;

      expect(sut.lines[0].timestamp, const Duration(minutes: 61, seconds: 5));
    });

    test('duplicates text for multiple timestamps on one line', () {
      final sut = SyncedLyricsModel.fromLrc('[00:12.34][00:17.80]Hello world')!;

      expect(sut.lines.length, 2);
      expect(sut.lines[0].timestamp, const Duration(milliseconds: 12340));
      expect(sut.lines[0].text, 'Hello world');
      expect(sut.lines[1].timestamp, const Duration(milliseconds: 17800));
      expect(sut.lines[1].text, 'Hello world');
    });

    test('sorts lines by timestamp', () {
      final sut = SyncedLyricsModel.fromLrc(
        '[00:30.00]Third\n[00:10.00]First\n[00:20.00]Second',
      )!;

      expect(sut.lines.map((l) => l.text).toList(), [
        'First',
        'Second',
        'Third',
      ]);
    });

    test('applies offset tag to all timestamps', () {
      final sut = SyncedLyricsModel.fromLrc(
        '[offset:+500]\n[00:12.00]Hello\n[00:17.00]Next',
      )!;

      expect(sut.offset, const Duration(milliseconds: 500));
      expect(sut.lines[0].timestamp, const Duration(milliseconds: 12500));
      expect(sut.lines[1].timestamp, const Duration(milliseconds: 17500));
    });

    test('applies negative offset and clamps at zero', () {
      final sut = SyncedLyricsModel.fromLrc(
        '[offset:-2000]\n[00:01.00]Hello\n[00:05.00]Next',
      )!;

      expect(sut.lines[0].timestamp, Duration.zero);
      expect(sut.lines[1].timestamp, const Duration(milliseconds: 3000));
    });

    test('ignores non-offset metadata tags', () {
      final sut = SyncedLyricsModel.fromLrc(
        '[ti:Title]\n[ar:Artist]\n[00:12.00]Hello',
      )!;

      expect(sut.lines.length, 1);
      expect(sut.lines[0].text, 'Hello');
    });

    test('preserves plain text lines at previous timestamp', () {
      final sut = SyncedLyricsModel.fromLrc(
        '[00:12.00]Hello\nA plain line\n[00:17.00]Next',
      )!;

      expect(sut.lines.length, 3);
      expect(sut.lines[1].text, 'A plain line');
      expect(sut.lines[1].timestamp, const Duration(milliseconds: 12000));
    });

    test('preserves leading plain text line at zero', () {
      final sut = SyncedLyricsModel.fromLrc('Intro\n[00:12.00]Hello')!;

      expect(sut.lines.length, 2);
      expect(sut.lines[0].text, 'Intro');
      expect(sut.lines[0].timestamp, Duration.zero);
    });

    test('returns null for plain lyrics without timestamps', () {
      expect(SyncedLyricsModel.fromLrc('Hello world\nNext line'), isNull);
    });

    test('returns null for empty input', () {
      expect(SyncedLyricsModel.fromLrc(''), isNull);
      expect(SyncedLyricsModel.fromLrc('\n\n'), isNull);
    });

    test('trims trailing whitespace from line text', () {
      final sut = SyncedLyricsModel.fromLrc('[00:12.00]Hello   ')!;

      expect(sut.lines[0].text, 'Hello');
    });
  });

  group('toString', () {
    test('reconstructs plain lyrics', () {
      final sut = SyncedLyricsModel.fromLrc(
        '[00:12.00]Hello world\n[00:17.00]Next line',
      )!;

      expect(sut.toString(), 'Hello world\nNext line\n');
    });
  });

  group('activeLineIndex', () {
    late SyncedLyrics sut;

    setUp(() {
      sut = SyncedLyricsModel.fromLrc(
        '[00:10.00]First\n[00:20.00]Second\n[00:30.00]Third',
      )!;
    });

    test('returns -1 before the first line', () {
      expect(sut.activeLineIndex(const Duration(milliseconds: 0)), -1);
      expect(sut.activeLineIndex(const Duration(milliseconds: 9999)), -1);
    });

    test('returns 0 at the first line timestamp', () {
      expect(sut.activeLineIndex(const Duration(milliseconds: 10000)), 0);
    });

    test('returns the active line for a position between lines', () {
      expect(sut.activeLineIndex(const Duration(milliseconds: 15000)), 0);
      expect(sut.activeLineIndex(const Duration(milliseconds: 25000)), 1);
    });

    test('returns the last line for a position after the last line', () {
      expect(sut.activeLineIndex(const Duration(milliseconds: 99999)), 2);
    });

    test('returns -1 for empty lines', () {
      final empty = SyncedLyrics(lines: []);
      expect(empty.activeLineIndex(const Duration(milliseconds: 1000)), -1);
    });
  });

  group('json round-trip', () {
    test('serializes and deserializes', () {
      final sut = SyncedLyricsModel.fromLrc(
        '[offset:+500]\n[00:12.00]Hello\n[00:17.00]Next',
      )!;

      final restored = SyncedLyricsModel.fromJson(sut.toJson())!;

      expect(restored.lines.length, sut.lines.length);
      expect(restored.lines[0].timestamp, sut.lines[0].timestamp);
      expect(restored.lines[0].text, sut.lines[0].text);
      expect(restored.lines[1].timestamp, sut.lines[1].timestamp);
      expect(restored.lines[1].text, sut.lines[1].text);
      expect(restored.offset, sut.offset);
    });

    test('returns null for null input', () {
      expect(SyncedLyricsModel.fromJson(null), isNull);
    });

    test('returns null for invalid json', () {
      expect(SyncedLyricsModel.fromJson('not json'), isNull);
    });
  });
}