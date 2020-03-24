import 'package:flutter_test/flutter_test.dart';
import 'package:mosh/domain/entities/album.dart';
import 'package:mosh/system/datasources/moor_music_data_source.dart';
import 'package:mosh/system/models/album_model.dart';

const TITLE = 'Back in Black';
const ARTIST = 'AC/DC';
const ALBUM_ART_PATH = '/music/acdc/backinblack.jpg';
const YEAR = 1980;

void main() {
  final tAlbumModel = AlbumModel(
      title: TITLE, artist: ARTIST, albumArtPath: ALBUM_ART_PATH, year: YEAR);

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
            artist: ARTIST,
            title: TITLE,
            albumArtPath: ALBUM_ART_PATH,
            year: YEAR);

        final albumModel = AlbumModel(
            artist: ARTIST,
            title: TITLE,
            albumArtPath: ALBUM_ART_PATH,
            year: YEAR);
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
            artist: ARTIST,
            title: TITLE,
            albumArtPath: ALBUM_ART_PATH,
            year: YEAR);

        final expected = AlbumModel(
            artist: ARTIST,
            title: TITLE,
            albumArtPath: ALBUM_ART_PATH,
            year: YEAR);
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
            artist: ARTIST,
            title: TITLE,
            year: YEAR);

        final expected = AlbumModel(
            artist: ARTIST,
            title: TITLE,
            year: YEAR);
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
            artist: ARTIST,
            title: TITLE,
            albumArtPath: ALBUM_ART_PATH);

        final expected = AlbumModel(
            artist: ARTIST,
            title: TITLE,
            albumArtPath: ALBUM_ART_PATH);
        // act
        final result = AlbumModel.fromMoor(moorAlbum);
        // assert
        expect(result, expected);
      },
    );
  });
}
