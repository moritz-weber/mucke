import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mucke/system/datasources/local_music_fetcher.dart';
import 'package:mucke/system/models/album_model.dart';
import 'package:mucke/system/models/song_model.dart';
import '../../test_constants.dart';

class MockFlutterAudioQuery extends Mock implements FlutterAudioQuery {}

class MockAlbumInfo extends Mock implements AlbumInfo {}

class MockSongInfo extends Mock implements SongInfo {}

void main() {
  LocalMusicFetcherImpl localMusicFetcher;
  MockFlutterAudioQuery mockFlutterAudioQuery;

  setUp(() {
    mockFlutterAudioQuery = MockFlutterAudioQuery();
    localMusicFetcher = LocalMusicFetcherImpl(mockFlutterAudioQuery);
  });

  group('getAlbums', () {
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
      'should fetch list of albums from FlutterAudioQuery',
      () async {
        // arrange
        when(mockFlutterAudioQuery.getAlbums())
            .thenAnswer((_) async => <AlbumInfo>[mockAlbumInfo]);
        // act
        await localMusicFetcher.getAlbums();
        // assert
        verify(mockFlutterAudioQuery.getAlbums());
      },
    );

    test(
      'should return albums as List<AlbumModel>',
      () async {
        // arrange
        when(mockFlutterAudioQuery.getAlbums())
            .thenAnswer((_) async => <AlbumInfo>[mockAlbumInfo]);

        final List<AlbumModel> expected = <AlbumModel>[
          AlbumModel.fromAlbumInfo(mockAlbumInfo),
        ];
        // act
        final List<AlbumModel> result = await localMusicFetcher.getAlbums();
        // assert
        expect(result, expected);
      },
    );
  });

  group('getSongs', () {
    MockSongInfo mockSongInfo;

    setUp(() {
      mockSongInfo = MockSongInfo();
      when(mockSongInfo.title).thenReturn(SONG_TITLE_3);
      when(mockSongInfo.album).thenReturn(ALBUM_TITLE_3);
      when(mockSongInfo.artist).thenReturn(ARTIST_3);
      when(mockSongInfo.filePath).thenReturn(PATH_3);
      when(mockSongInfo.track).thenReturn(TRACKNUMBER_3.toString());
      when(mockSongInfo.albumArtwork).thenReturn(ALBUM_ART_PATH_3);
    });

    test(
      'should fetch list of songs from FlutterAudioQuery',
      () async {
        // arrange
        when(mockFlutterAudioQuery.getSongs())
            .thenAnswer((_) async => <SongInfo>[mockSongInfo]);
        // act
        await localMusicFetcher.getSongs();
        // assert
        verify(mockFlutterAudioQuery.getSongs());
      },
    );

    test(
      'should return songs as List<SongModel>',
      () async {
        // arrange
        when(mockFlutterAudioQuery.getSongs())
            .thenAnswer((_) async => <SongInfo>[mockSongInfo]);

        final List<SongModel> expected = <SongModel>[
          SongModel.fromSongInfo(mockSongInfo),
        ];
        // act
        final List<SongModel> result = await localMusicFetcher.getSongs();
        // assert
        expect(result, expected);
      },
    );
  });
}
