import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mosh/system/datasources/local_music_fetcher_contract.dart';
import 'package:mosh/system/datasources/music_data_source_contract.dart';
import 'package:mosh/system/models/album_model.dart';
import 'package:mosh/system/repositories/music_data_repository_impl.dart';

import '../../test_constants.dart';

class MockLocalMusicFetcher extends Mock implements LocalMusicFetcher {}

class MockMusicDataSource extends Mock implements MusicDataSource {}

void main() {
  MusicDataRepositoryImpl repository;
  MockLocalMusicFetcher mockLocalMusicFetcher;
  MockMusicDataSource mockMusicDataSource;

  List<AlbumModel> tAlbumList;
  List<AlbumModel> tEmptyList;

  setUp(() {
    mockLocalMusicFetcher = MockLocalMusicFetcher();
    mockMusicDataSource = MockMusicDataSource();

    repository = MusicDataRepositoryImpl(
      localMusicFetcher: mockLocalMusicFetcher,
      musicDataSource: mockMusicDataSource,
    );

    tAlbumList = setupAlbumList(tAlbumList);

    tEmptyList = [];
  });

  group('getAlbums', () {
    test(
      'should get albums from MusicDataSource',
      () async {
        // arrange
        when(mockMusicDataSource.getAlbums())
            .thenAnswer((_) async => tAlbumList);
        // act
        final result = await repository.getAlbums();
        // assert
        verify(mockMusicDataSource.getAlbums());
        expect(result, Right(tAlbumList));
      },
    );

    test(
      'should return empty list when MusicDataSource does not return albums',
      () async {
        // arrange
        when(mockMusicDataSource.getAlbums())
            .thenAnswer((_) async => tEmptyList);
        // act
        final result = await repository.getAlbums();
        // assert
        verify(mockMusicDataSource.getAlbums());
        expect(result, Right(tEmptyList));
      },
    );
  });

  group('updateDatabase', () {
    setUp(() {});

    test(
      'should fetch list of albums from LocalMusicFetcher',
      () async {
        when(mockLocalMusicFetcher.getAlbums())
            .thenAnswer((_) async => tAlbumList);
        when(mockMusicDataSource.albumExists(any))
            .thenAnswer((_) async => false);
        // act
        repository.updateDatabase();
        // assert
        verify(mockLocalMusicFetcher.getAlbums());
      },
    );

    test(
      'should insert fetched albums to MusicDataSource',
      () async {
        // arrange
        when(mockLocalMusicFetcher.getAlbums())
            .thenAnswer((_) async => tAlbumList);
        when(mockMusicDataSource.albumExists(any))
            .thenAnswer((_) async => false);
        // act
        await repository.updateDatabase();
        // assert
        for (final album in tAlbumList) {
          verify(mockMusicDataSource.insertAlbum(album));
        }
      },
    );

    test(
      'should not insert albums that are already stored in MusicDataSource',
      () async {
        // arrange
        when(mockLocalMusicFetcher.getAlbums())
            .thenAnswer((_) async => tAlbumList);
        when(mockMusicDataSource.albumExists(tAlbumList[0]))
            .thenAnswer((_) async => true);
        when(mockMusicDataSource.albumExists(tAlbumList[1]))
            .thenAnswer((_) async => false);
        // act
        await repository.updateDatabase();
        // assert
        verifyNever(mockMusicDataSource.insertAlbum(tAlbumList[0]));
        verify(mockMusicDataSource.insertAlbum(tAlbumList[1]));
      },
    );
  });
}

List<AlbumModel> setupAlbumList(List<AlbumModel> tAlbumList) => [
      AlbumModel(
        artist: ARTIST_1,
        title: ALBUM_TITLE_1,
        albumArtPath: ALBUM_ART_PATH_1,
        year: YEAR_1,
      ),
      AlbumModel(
        artist: ARTIST_2,
        title: ALBUM_TITLE_2,
        albumArtPath: ALBUM_ART_PATH_2,
        year: YEAR_2,
      ),
    ];
