import '../../domain/repositories/platform_integration_repository.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';

abstract class PlatformIntegrationDataSource {
  Stream<PlatformIntegrationEvent> get eventStream;

  Future<void> handlePlaybackEvent(PlaybackEventModel playbackEventModel);
  Future<void> onPause();
  Future<void> onPlay();
  Future<void> setCurrentSong(SongModel songModel);
}