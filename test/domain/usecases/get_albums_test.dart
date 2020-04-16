import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mucke/domain/entities/album.dart';
import 'package:mucke/domain/repositories/music_data_repository.dart';
import 'package:mucke/domain/usecases/get_albums.dart';

class MockMusicDataRepository extends Mock implements MusicDataRepository {}

void main() {
  GetAlbums usecase;
  MockMusicDataRepository mockMusicDataRepository;

  setUp(() {
    mockMusicDataRepository = MockMusicDataRepository();
    usecase = GetAlbums(mockMusicDataRepository);
  });

  final tAlbums = <Album>[
    const Album(title: 'Back in Black', artist: 'AC/DC'),
    const Album(title: 'Twilight Of The Thunder God', artist: 'Amon Amarth'),
  ];

  test(
    'should get all albums from the repository',
    () async {
      // arrange
      when(mockMusicDataRepository.getAlbums())
          .thenAnswer((_) async => Right(tAlbums));
      // act
      final result = await usecase();
      // assert
      expect(result, Right(tAlbums));
      verify(mockMusicDataRepository.getAlbums());
      verifyNoMoreInteractions(mockMusicDataRepository);
    },
  );
}
