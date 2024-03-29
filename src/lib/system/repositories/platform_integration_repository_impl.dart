import 'package:flutter_fimber/flutter_fimber.dart';

import '../../domain/entities/playback_event.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/platform_integration_repository.dart';
import '../datasources/platform_integration_data_source.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';

class PlatformIntegrationRepositoryImpl implements PlatformIntegrationRepository {
  PlatformIntegrationRepositoryImpl(this._platformIntegrationDataSource);

  static final _log = FimberLog('PlatformIntegrationRepositoryImpl');

  final PlatformIntegrationDataSource _platformIntegrationDataSource;

  @override
  Stream<PlatformIntegrationEvent> get eventStream => _platformIntegrationDataSource.eventStream;

  @override
  void handlePlaybackEvent(PlaybackEvent playbackEvent) {
    _platformIntegrationDataSource.handlePlaybackEvent(playbackEvent as PlaybackEventModel);
  }

  @override
  void setCurrentSong(Song? song) {
    _log.d('setCurrentSong');
    _platformIntegrationDataSource.setCurrentSong(song != null ? song as SongModel : null);
  }
}
