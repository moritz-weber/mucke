import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mosh/domain/entities/album.dart';
import 'package:mosh/system/datasources/moor_music_data_source.dart';
import 'package:mosh/system/models/album_model.dart';

import '../../test_constants.dart';

class MockAlbumInfo extends Mock implements AlbumInfo {}

void main() {
  final tAlbumModel = AlbumModel(
    title: ALBUM_TITLE_1,
    artist: ARTIST_1,
    albumArtPath: ALBUM_ART_PATH_1,
    year: YEAR_1,
  );

  test(
    'should be subclass of Album entity',
    () async {
      // assert
      expect(tAlbumModel, isA<Album>());
    },
  );

  group('toMoor', () {
    test(
      'should return valid MoorAlbum',
      () async {
        // arrange
        final expected = MoorAlbum(
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
          year: YEAR_1,
        );

        final albumModel = AlbumModel(
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
          year: YEAR_1,
        );
        // act
        final result = albumModel.toMoor();
        // assert
        expect(result, expected);
      },
    );
  });

  group('fromMoor', () {
    test(
      'should create valid AlbumModel',
      () async {
        // arrange
        final moorAlbum = MoorAlbum(
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
          year: YEAR_1,
        );

        final expected = AlbumModel(
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
          year: YEAR_1,
        );
        // act
        final result = AlbumModel.fromMoor(moorAlbum);
        // assert
        expect(result, expected);
      },
    );

    test(
      'should create valid AlbumModel without albumArtPath',
      () async {
        // arrange
        final moorAlbum = MoorAlbum(
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          year: YEAR_1,
        );

        final expected = AlbumModel(
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          year: YEAR_1,
        );
        // act
        final result = AlbumModel.fromMoor(moorAlbum);
        // assert
        expect(result, expected);
      },
    );

    test(
      'should create valid AlbumModel without year',
      () async {
        // arrange
        final moorAlbum = MoorAlbum(
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
        );

        final expected = AlbumModel(
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
        );
        // act
        final result = AlbumModel.fromMoor(moorAlbum);
        // assert
        expect(result, expected);
      },
    );
  });

  group('fromAlbumInfo', () {
    MockAlbumInfo mockAlbumInfo;

    setUp(() {
      mockAlbumInfo = MockAlbumInfo();
      when(mockAlbumInfo.title).thenReturn(ALBUM_TITLE_1);
      when(mockAlbumInfo.albumArt).thenReturn(ALBUM_ART_PATH_1);
      when(mockAlbumInfo.artist).thenReturn(ARTIST_1);
      when(mockAlbumInfo.firstYear).thenReturn(FIRST_YEAR_1.toString());
      when(mockAlbumInfo.lastYear).thenReturn(LAST_YEAR_1.toString());
      when(mockAlbumInfo.numberOfSongs).thenReturn(NUM_SONGS_1.toString());
    });

    test(
      'should create AlbumModel from AlbumInfo',
      () async {
        // arrange
        final expected = AlbumModel(
          title: ALBUM_TITLE_1,
          artist: ARTIST_1,
          albumArtPath: ALBUM_ART_PATH_1,
          year: FIRST_YEAR_1,
        );
        // act
        final result = AlbumModel.fromAlbumInfo(mockAlbumInfo);
        // assert
        expect(result, expected);
      },
    );
  });
}
