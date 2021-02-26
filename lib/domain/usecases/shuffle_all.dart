import 'dart:math';

import '../entities/shuffle_mode.dart';
import '../entities/song.dart';
import '../modules/queue_generator.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/music_data_repository.dart';
import '../repositories/persistent_player_state_repository.dart';
import '../repositories/platform_integration_repository.dart';

const SHUFFLE_MODE = ShuffleMode.plus;

class ShuffleAll {
  ShuffleAll(
    this._audioPlayerRepository,
    this._musicDataRepository,
    this._platformIntegrationRepository,
    this._playerStateRepository,
    this._queueGenerationModule,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final MusicDataRepository _musicDataRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;
  final PlayerStateRepository _playerStateRepository;

  final QueueGenerationModule _queueGenerationModule;

  Future<void> call() async {
    final List<Song> songs = await _musicDataRepository.songStream.first;
    final rng = Random();
    final index = rng.nextInt(songs.length);

    _audioPlayerRepository.setShuffleMode(SHUFFLE_MODE);

    final queueItems = await _queueGenerationModule.generateQueue(
      SHUFFLE_MODE,
      songs,
      index,
    );

    await _audioPlayerRepository.loadQueue(
      initialIndex: 0,
      queue: queueItems,
    );
    _audioPlayerRepository.play();

    _platformIntegrationRepository.setCurrentSong(songs[index]);
    // _platformIntegrationRepository.play();
    _platformIntegrationRepository.setQueue(queueItems.map((e) => e.song).toList());
  }
}
