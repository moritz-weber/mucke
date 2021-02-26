import '../repositories/platform_integration_repository.dart';
import '../usecases/pause.dart';
import '../usecases/play.dart';

class PlatformIntegrationActor {
  PlatformIntegrationActor(this._platformIntegrationInfoRepository, this._pause, this._play) {
    _platformIntegrationInfoRepository.eventStream
        .listen((event) => _handlePlatformIntegrationEvent(event));
  }

  final PlatformIntegrationInfoRepository _platformIntegrationInfoRepository;

  final Pause _pause;
  final Play _play;

  void _handlePlatformIntegrationEvent(PlatformIntegrationEvent event) {
    switch (event.type) {
      case PlatformIntegrationEventType.play:
        _play();
        break;
      case PlatformIntegrationEventType.pause:
        _pause();
        break;
      default:
    }
  }
}
