import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:mosh/system/datasources/moor_music_data_source.dart';
import 'package:mosh/system/models/album_model.dart';
import 'package:mosh/system/models/song_model.dart';

import '../../test_constants.dart';

void main() {
  MoorMusicDataSource moorMusicDataSource;
  AlbumModel albumModel;
  SongModel songModel;

  setUp(() {
    moorMusicDataSource =
        MoorMusicDataSource.withQueryExecutor(VmDatabase.memory());

    albumModel = AlbumModel(
      title: ALBUM_TITLE_1,
      artist: ARTIST_1,
      albumArtPath: ALBUM_ART_PATH_1,
      pubYear: YEAR_1,
    );

    songModel = SongModel(
      title: SONG_TITLE_3,
      album: ALBUM_TITLE_3,
      artist: ARTIST_3,
      path: PATH_3,
      duration: DURATION_3,
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

  group('albumExists', () {
    test(
      'should return true when album exists in data source',
      () async {
        // arrange
        moorMusicDataSource.insertAlbum(albumModel);
        // act
        final bool result = await moorMusicDataSource.albumExists(albumModel);
        // assert
        assert(result);
      },
    );

    test(
      'should return false when album does not exists in data source',
      () async {
        // act
        final bool result = await moorMusicDataSource.albumExists(albumModel);
        // assert
        assert(!result);
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

  group('songExists', () {
    test(
      'should return true when song exists in data source',
      () async {
        // arrange
        moorMusicDataSource.insertSong(songModel);
        // act
        final bool result = await moorMusicDataSource.songExists(songModel);
        // assert
        assert(result);
      },
    );

    test(
      'should return false when song does not exists in data source',
      () async {
        // act
        final bool result = await moorMusicDataSource.songExists(songModel);
        // assert
        assert(!result);
      },
    );
  });
}
