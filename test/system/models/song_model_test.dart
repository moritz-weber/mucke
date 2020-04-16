import 'package:audio_service/audio_service.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moor/moor.dart';
import 'package:mucke/domain/entities/song.dart';
import 'package:mucke/system/datasources/moor_music_data_source.dart';
import 'package:mucke/system/models/song_model.dart';

import '../../test_constants.dart';

class MockSongInfo extends Mock implements SongInfo {}

void main() {
  final tSongModel = SongModel(
    title: SONG_TITLE_3,
    album: ALBUM_TITLE_3,
    artist: ARTIST_3,
    path: PATH_3,
    duration: DURATION_3,
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

  group('toSongsCompanion', () {
    test(
      'should return valid SongsCompanion',
      () async {
        // arrange
        final expected = SongsCompanion(
          album: Value(ALBUM_TITLE_3),
          artist: Value(ARTIST_3),
          title: Value(SONG_TITLE_3),
          path: Value(PATH_3),
          duration: Value(DURATION_3),
          albumArtPath: Value(ALBUM_ART_PATH_3),
          trackNumber: Value(TRACKNUMBER_3),
        );

        final songModel = SongModel(
          album: ALBUM_TITLE_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
        );
        // act
        final result = songModel.toSongsCompanion();
        // assert
        expect(result.album.value, expected.album.value);
        expect(result.artist.value, expected.artist.value);
        expect(result.title.value, expected.title.value);
        expect(result.path.value, expected.path.value);
        expect(result.albumArtPath.value, expected.albumArtPath.value);
        expect(result.trackNumber.value, expected.trackNumber.value);
      },
    );
  });

  group('toMediaItem', () {
    test(
      'should return valid MediaItem',
      () async {
        // arrange
        final expected = MediaItem(
          id: PATH_3,
          title: SONG_TITLE_3,
          album: ALBUM_TITLE_3,
          artist: ARTIST_3,
          duration: DURATION_3,
          artUri: 'file://$ALBUM_ART_PATH_3',
        );

        final songModel = SongModel(
          album: ALBUM_TITLE_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
        );
        // act
        final result = songModel.toMediaItem();
        // assert
        expect(result.album, expected.album);
        expect(result.artist, expected.artist);
        expect(result.title, expected.title);
        expect(result.id, expected.id);
        expect(result.duration, expected.duration);
        expect(result.artUri, expected.artUri);
      },
    );
  });

  group('fromMoorSong', () {
    test(
      'should create valid SongModel',
      () async {
        // arrange
        final moorSong = MoorSong(
          album: ALBUM_TITLE_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
        );

        final expected = SongModel(
          album: ALBUM_TITLE_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
        );
        // act
        final result = SongModel.fromMoorSong(moorSong);
        // assert
        expect(result, expected);
      },
    );
  });

  group('fromAlbumInfo', () {
    MockSongInfo mockSongInfo;

    setUp(() {
      mockSongInfo = MockSongInfo();
      when(mockSongInfo.album).thenReturn(ALBUM_TITLE_3);
      when(mockSongInfo.artist).thenReturn(ARTIST_3);
      when(mockSongInfo.title).thenReturn(SONG_TITLE_3);
      when(mockSongInfo.albumArtwork).thenReturn(ALBUM_ART_PATH_3);
      when(mockSongInfo.filePath).thenReturn(PATH_3);
      when(mockSongInfo.duration).thenReturn(DURATION_3.toString());
      when(mockSongInfo.track).thenReturn(TRACKNUMBER_3.toString());
    });

    test(
      'should create SongModel from AlbumInfo',
      () async {
        // arrange
        final expected = SongModel(
          album: ALBUM_TITLE_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
        );
        // act
        final result = SongModel.fromSongInfo(mockSongInfo);
        // assert
        expect(result, expected);
      },
    );
  });
}
