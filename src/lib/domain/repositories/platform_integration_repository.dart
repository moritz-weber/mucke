import '../entities/event.dart';
import '../entities/playback_event.dart';
import '../entities/song.dart';


abstract class PlatformIntegrationInfoRepository {
  Stream<PlatformIntegrationEvent> get eventStream;
}

abstract class PlatformIntegrationRepository extends PlatformIntegrationInfoRepository {
  void handlePlaybackEvent(PlaybackEvent playbackEvent);
  void setCurrentSong(Song? song);
}

class PlatformIntegrationEvent extends Event {
  PlatformIntegrationEvent({required this.type, Map<String, dynamic>? payload}) : super(payload);

  final PlatformIntegrationEventType type;
}

enum PlatformIntegrationEventType {
  play,
  pause,
  stop,
  skipNext,
  skipPrevious,
  seek,
  like,
}
