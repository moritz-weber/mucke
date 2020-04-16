import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mucke/domain/entities/song.dart';
import 'package:mucke/domain/repositories/music_data_repository.dart';
import 'package:mucke/domain/usecases/get_songs.dart';

import '../../test_constants.dart';

class MockMusicDataRepository extends Mock implements MusicDataRepository {}

void main() {
  GetSongs usecase;
  MockMusicDataRepository mockMusicDataRepository;

  setUp(() {
    mockMusicDataRepository = MockMusicDataRepository();
    usecase = GetSongs(mockMusicDataRepository);
  });

  final tSongs = <Song>[
    Song(
      album: ALBUM_TITLE_3,
      artist: ARTIST_3,
      title: SONG_TITLE_3,
      path: PATH_3,
      duration: DURATION_3,
      albumArtPath: ALBUM_ART_PATH_3,
      trackNumber: TRACKNUMBER_3,
    ),
    Song(
      album: ALBUM_TITLE_4,
      artist: ARTIST_4,
      title: SONG_TITLE_4,
      path: PATH_4,
      duration: DURATION_4,
      albumArtPath: ALBUM_ART_PATH_4,
      trackNumber: TRACKNUMBER_4,
    ),
  ];

  test(
    'should get all songs from the repository',
    () async {
      // arrange
      when(mockMusicDataRepository.getSongs())
          .thenAnswer((_) async => Right(tSongs));
      // act
      final result = await usecase();
      // assert
      expect(result, Right(tSongs));
      verify(mockMusicDataRepository.getSongs());
      verifyNoMoreInteractions(mockMusicDataRepository);
    },
  );
}
