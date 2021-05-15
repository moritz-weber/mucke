import '../entities/song.dart';
import '../repositories/audio_player_repository.dart';
import '../repositories/platform_integration_repository.dart';

class PlayNext {
  PlayNext(
    this._audioPlayerRepository,
    this._platformIntegrationRepository,
  );

  final AudioPlayerRepository _audioPlayerRepository;
  final PlatformIntegrationRepository _platformIntegrationRepository;

  Future<void> call(Song song) async {
    await _audioPlayerRepository.playNext(song);

    final songList = _audioPlayerRepository.queueStream.valueWrapper.value;
    _platformIntegrationRepository.setQueue(songList);
  }
}
