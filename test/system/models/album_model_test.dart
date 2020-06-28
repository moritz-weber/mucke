import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moor/moor.dart';
import 'package:mucke/domain/entities/album.dart';
import 'package:mucke/system/datasources/moor_music_data_source.dart';
import 'package:mucke/system/models/album_model.dart';

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

  group('toAlbumsCompanion', () {
    test(
      'should return valid AlbumsCompanion',
      () async {
        // arrange
        final expected = AlbumsCompanion(
          artist: Value(ARTIST_1),
          title: Value(ALBUM_TITLE_1),
          albumArtPath: Value(ALBUM_ART_PATH_1),
          year: Value(YEAR_1),
        );

        final albumModel = AlbumModel(
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
          year: YEAR_1,
        );
        // act
        final result = albumModel.toAlbumsCompanion();
        // assert
        expect(result.artist.value, expected.artist.value);
        expect(result.title.value, expected.title.value);
        expect(result.albumArtPath.value, expected.albumArtPath.value);
        expect(result.year.value, expected.year.value);
      },
    );
  });

  group('fromMoorAlbum', () {
    test(
      'should create valid AlbumModel',
      () async {
        // arrange
        final moorAlbum = MoorAlbum(
          id: ID_1,
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
          year: YEAR_1,
          present: PRESENT_1,
        );

        final expected = AlbumModel(
          id: ID_1,
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
          year: YEAR_1,
        );
        // act
        final result = AlbumModel.fromMoorAlbum(moorAlbum);
        // assert
        expect(result, expected);
      },
    );

    test(
      'should create valid AlbumModel without albumArtPath',
      () async {
        // arrange
        final moorAlbum = MoorAlbum(
          id: ID_1,
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          year: YEAR_1,
          present: PRESENT_1,
        );

        final expected = AlbumModel(
          id: ID_1,
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          year: YEAR_1,
        );
        // act
        final result = AlbumModel.fromMoorAlbum(moorAlbum);
        // assert
        expect(result, expected);
      },
    );

    test(
      'should create valid AlbumModel without year',
      () async {
        // arrange
        final moorAlbum = MoorAlbum(
          id: ID_1,
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
          present: PRESENT_1,
        );

        final expected = AlbumModel(
          artist: ARTIST_1,
          title: ALBUM_TITLE_1,
          albumArtPath: ALBUM_ART_PATH_1,
        );
        // act
        final result = AlbumModel.fromMoorAlbum(moorAlbum);
        // assert
        expect(result, expected);
      },
    );
  });

  group('fromAlbumInfo', () {
    MockAlbumInfo mockAlbumInfo;

    setUp(() {
      mockAlbumInfo = MockAlbumInfo();
      when(mockAlbumInfo.id).thenReturn(ID_1.toString());
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
          id: ID_1,
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
