import '../entities/song.dart';
import '../modules/queue_manager.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/platform_integration_repository.dart';

class PlayNext {
  PlayNext(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
    this._queueManagerModule,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;

  final QueueManagerModule _queueManagerModule;

  Future<void> call(Song song) async {
    final currentIndex = _audioPlayerRepository.currentIndexStream.valueWrapper.value;

    _queueManagerModule.insertIntoQueue(song, currentIndex + 1);
    await _audioPlayerRepository.playNext(song);

    final songList = _audioPlayerRepository.queueStream.valueWrapper.value;
    print(songList.length);
    _platformIntegrationRepository.setQueue(songList);
  }
}
