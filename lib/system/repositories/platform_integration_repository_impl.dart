import '../../domain/entities/playback_event.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/platform_integration_repository.dart';
import '../datasources/platform_integration_data_source.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';

class PlatformIntegrationRepositoryImpl implements PlatformIntegrationRepository {
  PlatformIntegrationRepositoryImpl(this._platformIntegrationDataSource);

  final PlatformIntegrationDataSource _platformIntegrationDataSource;

  @override
  Stream<PlatformIntegrationEvent> get eventStream => _platformIntegrationDataSource.eventStream;

  @override
  void handlePlaybackEvent(PlaybackEvent playbackEvent) {
    _platformIntegrationDataSource.handlePlaybackEvent(playbackEvent as PlaybackEventModel);
  }

  @override
  void pause() {
    _platformIntegrationDataSource.onPause();
  }

  @override
  void play() {
    _platformIntegrationDataSource.onPlay();
  }

  @override
  void onStop() {
    // TODO: implement onStop
  }

  @override
  void setCurrentSong(Song song) {
    _platformIntegrationDataSource.setCurrentSong(song as SongModel);
  }

  @override
  void setQueue(List<Song> queue) {
    // TODO: implement setQueue
  }
}
