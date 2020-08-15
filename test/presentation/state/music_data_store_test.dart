import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:mucke/core/error/failures.dart';
import 'package:mucke/domain/entities/artist.dart';
import 'package:mucke/domain/repositories/music_data_repository.dart';
import 'package:mucke/presentation/state/music_data_store.dart';

class MockMusicDataRepository extends Mock implements MusicDataRepository {}

class MockInitMusicDataStore extends MusicDataStore {
  MockInitMusicDataStore({@required MusicDataRepository musicDataRepository})
      : super(musicDataRepository: musicDataRepository);

  int fetchArtistsCalled = 0;
  int fetchAlbumsCalled = 0;
  int fetchSongsCalled = 0;

  @override
  Future<void> fetchArtists() async {
    fetchArtistsCalled++;
  }

  @override
  Future<void> fetchAlbums() async {
    fetchAlbumsCalled++;
  }

  @override
  Future<void> fetchSongs() async {
    fetchSongsCalled++;
  }
}

void main() {
  group('init', () {
    MockMusicDataRepository mockMusicDataRepository;

    setUp(() {
      mockMusicDataRepository = MockMusicDataRepository();
    });

    test(
      'should fetch artists, albums and songs from the database',
      () async {
        // arrange
        final MockInitMusicDataStore mockInitMusicDataStore =
            MockInitMusicDataStore(
                musicDataRepository: mockMusicDataRepository);

        // act
        mockInitMusicDataStore.init();

        // assert
        expect(mockInitMusicDataStore.fetchArtistsCalled, 1);
        expect(mockInitMusicDataStore.fetchAlbumsCalled, 1);
        expect(mockInitMusicDataStore.fetchSongsCalled, 1);
      },
    );

    test(
      'should only fetch data once',
      () async {
        // arrange
        final MockInitMusicDataStore mockInitMusicDataStore =
            MockInitMusicDataStore(
                musicDataRepository: mockMusicDataRepository);

        // act
        mockInitMusicDataStore.init();
        mockInitMusicDataStore.init();

        // assert
        expect(mockInitMusicDataStore.fetchArtistsCalled, 1);
        expect(mockInitMusicDataStore.fetchAlbumsCalled, 1);
        expect(mockInitMusicDataStore.fetchSongsCalled, 1);
      },
    );
  });

  group('fetchArtists', () {
    MockMusicDataRepository mockMusicDataRepository;
    const List<Artist> artists = [
      Artist(name: 'AC/DC'),
      Artist(name: 'Amon Amarth'),
    ];

    const Either<Failure, List<Artist>> success =
        Right<Failure, List<Artist>>(artists);

    final Either<Failure, List<Artist>> failure = Left(GenericFailure());

    setUp(() {
      mockMusicDataRepository = MockMusicDataRepository();
    });

    test(
      'should store a list of artists on success',
      () async {
        // arrange
        when(mockMusicDataRepository.getArtists())
            .thenAnswer((_) => Future.value(success));

        final musicDataStore = MusicDataStore(musicDataRepository: mockMusicDataRepository);

        // act
        await musicDataStore.fetchArtists();

        // assert
        expect(musicDataStore.artists.toList(), artists);
      },
    );

    test(
      'should store an empty list of artists on failure',
      () async {
        // arrange
        when(mockMusicDataRepository.getArtists())
            .thenAnswer((_) => Future.value(failure));

        final musicDataStore = MusicDataStore(musicDataRepository: mockMusicDataRepository);

        // act
        await musicDataStore.fetchArtists();

        // assert
        expect(musicDataStore.artists.toList(), []);
      },
    );
  });
}
