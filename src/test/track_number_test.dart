import 'package:mucke/system/models/song_model.dart';
import 'package:test/test.dart';

void main() {
  // four digits lead to invalid numbers from plugin:
  // x-1234:1234 (ok in theory but not unambiguous)
  // 1-4444:5444
  // 123-4567:127567
  test('Base case: single digit disc & <3 digit track', () {
    expect(SongModel.parseTrackNumber(1001), [1, 1]);
    expect(SongModel.parseTrackNumber(2003), [2, 3]);
    expect(SongModel.parseTrackNumber(1010), [1, 10]);
  });

  test('double digit disc', () {
    expect(SongModel.parseTrackNumber(10001), [10, 1]);
    expect(SongModel.parseTrackNumber(10010), [10, 10]);
    expect(SongModel.parseTrackNumber(10100), [10, 100]);
    expect(SongModel.parseTrackNumber(12999), [12, 999]);
  });

  test('triple digit track', () {
    expect(SongModel.parseTrackNumber(1100), [1, 100]);
    expect(SongModel.parseTrackNumber(1101), [1, 101]);
    expect(SongModel.parseTrackNumber(1999), [1, 999]);
    expect(SongModel.parseTrackNumber(12999), [12, 999]);
  });

  test('no disc', () {
    expect(SongModel.parseTrackNumber(10), [1, 10]);
    expect(SongModel.parseTrackNumber(40), [1, 40]);
    expect(SongModel.parseTrackNumber(1), [1, 1]);
  });

  test('triple digit disc', () {
    expect(SongModel.parseTrackNumber(123004), [123, 4]);
    expect(SongModel.parseTrackNumber(123045), [123, 45]);
    expect(SongModel.parseTrackNumber(123456), [123, 456]);
  });
}
