import '../entities/event.dart';
import '../entities/playback_event.dart';
import '../entities/song.dart';

/*

- position
- controls (playbackState)

*/

abstract class PlatformIntegrationInfoRepository {
  Stream<PlatformIntegrationEvent> get eventStream;
}

abstract class PlatformIntegrationRepository extends PlatformIntegrationInfoRepository {
  void play();
  void pause();
  void onStop();

  void handlePlaybackEvent(PlaybackEvent playbackEvent);
  void setCurrentSong(Song song);
  void setQueue(List<Song> queue);
}

class PlatformIntegrationEvent extends Event {
  PlatformIntegrationEvent({this.type});

  final PlatformIntegrationEventType type;
}

enum PlatformIntegrationEventType {
  play,
  pause,
  stop,
  skipNext,
  skipPrevious,
}
