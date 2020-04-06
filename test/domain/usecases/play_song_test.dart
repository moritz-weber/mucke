import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mosh/domain/entities/song.dart';
import 'package:mosh/domain/repositories/audio_repository.dart';
import 'package:mosh/domain/usecases/play_song.dart';

import '../../test_constants.dart';

class MockAudioRepository extends Mock implements AudioRepository {}

void main() {
  PlaySong usecase;
  MockAudioRepository mockAudioRepository;

  setUp(() {
    mockAudioRepository = MockAudioRepository();
    usecase = PlaySong(mockAudioRepository);
  });

  const tIndex = 0;

  final tSongList = <Song>[
    Song(
      album: ALBUM_TITLE_3,
      artist: ARTIST_3,
      title: SONG_TITLE_3,
      path: PATH_3,
      albumArtPath: ALBUM_ART_PATH_3,
      trackNumber: TRACKNUMBER_3,
    ),
    Song(
      album: ALBUM_TITLE_4,
      artist: ARTIST_4,
      title: SONG_TITLE_4,
      path: PATH_4,
      albumArtPath: ALBUM_ART_PATH_4,
      trackNumber: TRACKNUMBER_4,
    ),
  ];

  test(
    'should forward index and song list to repository',
    () async {
      // act
      await usecase(Params(tIndex, tSongList));
      // assert
      verify(mockAudioRepository.playSong(tIndex, tSongList));
      verifyNoMoreInteractions(mockAudioRepository);
    },
  );
}
