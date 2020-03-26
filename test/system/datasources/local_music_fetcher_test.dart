import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mosh/system/datasources/local_music_fetcher.dart';
import 'package:mosh/system/models/album_model.dart';
import '../../test_constants.dart';

class MockFlutterAudioQuery extends Mock implements FlutterAudioQuery {}

class MockAlbumInfo extends Mock implements AlbumInfo {}

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
      when(mockAlbumInfo.title).thenReturn(TITLE_1);
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
}
