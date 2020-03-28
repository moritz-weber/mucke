import 'package:flutter_test/flutter_test.dart';
import 'package:mosh/domain/entities/song.dart';
import 'package:mosh/system/models/song_model.dart';

import '../../test_constants.dart';

void main() {
  final tSongModel = SongModel(
    title: SONG_TITLE_3,
    album: ALBUM_TITLE_3,
    artist: ARTIST_3,
    path: PATH_3,
    trackNumber: TRACKNUMBER_3,
    albumArtPath: ALBUM_ART_PATH_3,
  );

  test(
    'should be subclass of Album entity',
    () async {
      // assert
      expect(tSongModel, isA<Song>());
    },
  );
}
