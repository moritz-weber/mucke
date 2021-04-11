import '../repositories/platform_integration_repository.dart';
import '../usecases/pause.dart';
import '../usecases/play.dart';
import '../usecases/seek_to_next.dart';
import '../usecases/seek_to_previous.dart';

class PlatformIntegrationActor {
  PlatformIntegrationActor(this._platformIntegrationInfoRepository, this._pause, this._play, this._seekToNext, this._seekToPrevious) {
    _platformIntegrationInfoRepository.eventStream
        .listen((event) => _handlePlatformIntegrationEvent(event));
  }

  final PlatformIntegrationInfoRepository _platformIntegrationInfoRepository;

  final Pause _pause;
  final Play _play;
  final SeekToNext _seekToNext;
  final SeekToPrevious _seekToPrevious;

  void _handlePlatformIntegrationEvent(PlatformIntegrationEvent event) {
    switch (event.type) {
      case PlatformIntegrationEventType.play:
        _play();
        break;
      case PlatformIntegrationEventType.pause:
        _pause();
        break;
      case PlatformIntegrationEventType.skipNext:
        _seekToNext();
        break;
      case PlatformIntegrationEventType.skipPrevious:
        _seekToPrevious();
        break;
      default:
    }
  }
}
