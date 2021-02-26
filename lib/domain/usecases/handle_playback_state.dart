import '../entities/playback_event.dart';
import '../repositories/platform_integration_repository.dart';

class HandlePlaybackEvent {
  HandlePlaybackEvent(this._platformIntegrationRepository);

  final PlatformIntegrationRepository _platformIntegrationRepository;

  Future<void> call(PlaybackEvent playbackEvent) async {
    _platformIntegrationRepository.handlePlaybackEvent(playbackEvent);
  }
}