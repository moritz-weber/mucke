import 'package:flutter_test/flutter_test.dart';
import 'package:moor/ffi.dart';
import 'package:mucke/system/datasources/moor_database.dart';
import 'package:mucke/system/models/album_model.dart';
import 'package:mucke/system/models/song_model.dart';

import '../../test_constants.dart';

void main() {
  MoorDatabase moorMusicDataSource;
  AlbumModel albumModel;
  SongModel songModel;

  setUp(() {
    moorMusicDataSource =
        MoorDatabase.withQueryExecutor(VmDatabase.memory());

    albumModel = const AlbumModel(
      title: ALBUM_TITLE_1,
      artist: ARTIST_1,
      albumArtPath: ALBUM_ART_PATH_1,
      year: YEAR_1,
    );

    songModel = const SongModel(
      title: SONG_TITLE_3,
      album: ALBUM_TITLE_3,
      albumId: ALBUM_ID_3,
      artist: ARTIST_3,
      path: PATH_3,
      duration: DURATION_3,
      blocked: BLOCKED_3,
      trackNumber: TRACKNUMBER_3,
      albumArtPath: ALBUM_ART_PATH_3,
    );
  });

  tearDown(() async {
    await moorMusicDataSource.close();
  });

  group('insertAlbum and getAlbums', () {
    test(
      'should return the album that was inserted',
      () async {
        // act
        moorMusicDataSource.insertAlbum(albumModel);
        // assert
        final List<AlbumModel> albums = await moorMusicDataSource.getAlbums();
        expect(albums.first, albumModel);
      },
    );
  });

  group('insertSong and getSongs', () {
    test(
      'should return the song that was inserted',
      () async {
        // act
        moorMusicDataSource.insertSong(songModel);
        // assert
        final List<SongModel> songs = await moorMusicDataSource.getSongs();
        expect(songs.first, songModel);
      },
    );
  });
}
