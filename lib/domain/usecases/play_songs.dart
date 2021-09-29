import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/platform_integration_repository.dart';

class PlaySongs {
  PlaySongs(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;

  /// Generate and play a queue from the [songs] according to current AudioPlayer settings.
  Future<void> call({required List<Song> songs, required int initialIndex}) async {
    if (0 <= initialIndex && initialIndex < songs.length) {
      await _audioPlayerRepository.loadSongs(
        initialIndex: initialIndex,
        songs: songs,
      );
      _audioPlayerRepository.play();

      _platformIntegrationRepository.setCurrentSong(songs[initialIndex]);
      _platformIntegrationRepository.setQueue(
        _audioPlayerRepository.queueStream.value,
      );
    }
  }
}
