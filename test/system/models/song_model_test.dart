import 'package:audio_service/audio_service.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moor/moor.dart';
import 'package:mucke/domain/entities/song.dart';
import 'package:mucke/system/datasources/moor_database.dart';
import 'package:mucke/system/models/song_model.dart';

import '../../test_constants.dart';

class MockSongInfo extends Mock implements SongInfo {}

void main() {
  const tSongModel = SongModel(
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

  test(
    'should be subclass of Song entity',
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
        const expected = SongsCompanion(
          albumTitle: Value(ALBUM_TITLE_3),
          albumId: Value(ALBUM_ID_3),
          artist: Value(ARTIST_3),
          title: Value(SONG_TITLE_3),
          path: Value(PATH_3),
          duration: Value(DURATION_3),
          blocked: Value(BLOCKED_3),
          albumArtPath: Value(ALBUM_ART_PATH_3),
          trackNumber: Value(TRACKNUMBER_3),
        );

        const songModel = SongModel(
          album: ALBUM_TITLE_3,
          albumId: ALBUM_ID_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          blocked: BLOCKED_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
        );
        // act
        final result = songModel.toSongsCompanion();
        // assert
        expect(result.albumTitle.value, expected.albumTitle.value);
        expect(result.albumId.value, expected.albumId.value);
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
            duration: const Duration(milliseconds: DURATION_3),
            artUri: 'file://$ALBUM_ART_PATH_3',
            extras: {
              'albumId': ALBUM_ID_3,
              'blocked': BLOCKED_3.toString(),
              'discNumber': null,
              'trackNumber': TRACKNUMBER_3,
            });

        const songModel = SongModel(
          album: ALBUM_TITLE_3,
          albumId: ALBUM_ID_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          blocked: BLOCKED_3,
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
        expect(result.extras, expected.extras);
      },
    );
  });

  group('fromMoorSong', () {
    test(
      'should create valid SongModel',
      () async {
        // arrange
        final moorSong = MoorSong(
          albumTitle: ALBUM_TITLE_3,
          albumId: ALBUM_ID_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
          present: PRESENT_3,
          blocked: BLOCKED_3,
        );

        const expected = SongModel(
          album: ALBUM_TITLE_3,
          albumId: ALBUM_ID_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          blocked: BLOCKED_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
        );
        // act
        final result = SongModel.fromMoor(moorSong);
        // assert
        expect(result, expected);
      },
    );
  });

  group('fromSongInfo', () {
    MockSongInfo mockSongInfo;

    setUp(() {
      mockSongInfo = MockSongInfo();
      when(mockSongInfo.album).thenReturn(ALBUM_TITLE_3);
      when(mockSongInfo.albumId).thenReturn(ALBUM_ID_3.toString());
      when(mockSongInfo.artist).thenReturn(ARTIST_3);
      when(mockSongInfo.title).thenReturn(SONG_TITLE_3);
      when(mockSongInfo.albumArtwork).thenReturn(ALBUM_ART_PATH_3);
      when(mockSongInfo.filePath).thenReturn(PATH_3);
      when(mockSongInfo.duration).thenReturn(DURATION_3.toString());
      when(mockSongInfo.track).thenReturn(TRACKNUMBER_3.toString());
    });

    test(
      'should create SongModel from SongInfo',
      () async {
        // arrange
        const expected = SongModel(
          album: ALBUM_TITLE_3,
          albumId: ALBUM_ID_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          blocked: false,
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

  group('fromMediaItem', () {
    test(
      'should create valid SongModel from MediaItem',
      () async {
        // arrange
        const mediaItem = MediaItem(
          id: PATH_3,
          title: SONG_TITLE_3,
          album: ALBUM_TITLE_3,
          artist: ARTIST_3,
          duration: Duration(milliseconds: DURATION_3),
          artUri: 'file://$ALBUM_ART_PATH_3',
          extras: {
            'albumId': ALBUM_ID_3,
            'trackNumber': TRACKNUMBER_3,
            'blocked': BLOCKED_3,
          },
        );

        const expected = SongModel(
          album: ALBUM_TITLE_3,
          albumId: ALBUM_ID_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          blocked: BLOCKED_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
        );
        // act
        final result = SongModel.fromMediaItem(mediaItem);
        // assert
        expect(result, expected);
      },
    );

    test(
      'should return null',
      () async {
        // arrange
        const mediaItem = null;
        const expected = null;
        // act
        final result = SongModel.fromMediaItem(mediaItem as MediaItem);
        // assert
        expect(result, expected);
      },
    );
  });

  group('copyWith', () {
    SongModel songModel;

    setUp(() {
      songModel = const SongModel(
        album: ALBUM_TITLE_3,
        albumId: ALBUM_ID_3,
        artist: ARTIST_3,
        title: SONG_TITLE_3,
        path: PATH_3,
        duration: DURATION_3,
        blocked: BLOCKED_3,
        albumArtPath: ALBUM_ART_PATH_3,
        trackNumber: TRACKNUMBER_3,
      );
    });

    test(
      'should create SongModel with same values',
      () async {
        // arrange
        const expected = SongModel(
          album: ALBUM_TITLE_3,
          albumId: ALBUM_ID_3,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          blocked: BLOCKED_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
        );
        // act
        final result = songModel.copyWith();
        // assert
        expect(result, expected);
      },
    );

    test(
      'should create SongModel with different album and albumId',
      () async {
        // arrange
        const expected = SongModel(
          album: ALBUM_TITLE_4,
          albumId: ALBUM_ID_4,
          artist: ARTIST_3,
          title: SONG_TITLE_3,
          path: PATH_3,
          duration: DURATION_3,
          blocked: BLOCKED_3,
          albumArtPath: ALBUM_ART_PATH_3,
          trackNumber: TRACKNUMBER_3,
        );
        // act
        final result = songModel.copyWith(
          album: ALBUM_TITLE_4,
          albumId: ALBUM_ID_4,
        );
        // assert
        expect(result, expected);
      },
    );
  });
}
