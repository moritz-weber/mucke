import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../modules/queue_manager.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/persistent_player_state_repository.dart';
import '../repositories/platform_integration_repository.dart';

class PlaySongs {
  PlaySongs(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
    this._playerStateRepository,
    this._queueGenerationModule,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;
  final PlayerStateRepository _playerStateRepository;

  final QueueManagerModule _queueGenerationModule;

  Future<void> call({List<Song> songs, int initialIndex}) async {
    if (0 <= initialIndex && initialIndex < songs.length) {
      // _audioPlayerRepository.playSong(songs[initialIndex]);

      final shuffleMode = _audioPlayerRepository.shuffleModeStream.valueWrapper.value;

      await _queueGenerationModule.setQueue(
        shuffleMode,
        songs,
        initialIndex,
      );

      final queueItems = _queueGenerationModule.queue;
      final songList = queueItems.map((e) => e.song).toList();

      await _audioPlayerRepository.loadQueue(
        initialIndex: shuffleMode == ShuffleMode.none ? initialIndex : 0,
        queue: songList,
      );
      _audioPlayerRepository.play();

      _platformIntegrationRepository.setCurrentSong(songs[initialIndex]);
      // _platformIntegrationRepository.play();
      _platformIntegrationRepository.setQueue(songList);
    }
  }
}
