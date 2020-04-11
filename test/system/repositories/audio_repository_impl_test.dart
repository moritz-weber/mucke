import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mosh/system/datasources/audio_manager_contract.dart';
import 'package:mosh/system/models/song_model.dart';
import 'package:mosh/system/repositories/audio_repository_impl.dart';

import '../../test_constants.dart';

class MockAudioManager extends Mock implements AudioManager {}

void main() {
  AudioRepositoryImpl repository;
  MockAudioManager mockAudioManager;

  const int tIndex = 0;
  final List<SongModel> tSongList = setupSongList();

  setUp(() {
    mockAudioManager = MockAudioManager();
    repository = AudioRepositoryImpl(mockAudioManager);
  });

  group('playSong', () {
    test(
      'should forward index and song list to AudioManager',
      () async {
        // act
        await repository.playSong(tIndex, tSongList);
        // assert
        verify(mockAudioManager.playSong(tIndex, tSongList));
      },
    );
  });
}

List<SongModel> setupSongList() => [
      SongModel(
        title: SONG_TITLE_3,
        album: ALBUM_TITLE_3,
        artist: ARTIST_3,
        path: PATH_3,
        duration: DURATION_3,
        trackNumber: TRACKNUMBER_3,
        albumArtPath: ALBUM_ART_PATH_3,
      ),
      SongModel(
        title: SONG_TITLE_4,
        album: ALBUM_TITLE_4,
        artist: ARTIST_4,
        path: PATH_4,
        duration: DURATION_4,
        trackNumber: TRACKNUMBER_4,
        albumArtPath: ALBUM_ART_PATH_4,
      ),
    ];
