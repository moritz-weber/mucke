import 'package:audio_service/audio_service.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/playback_event.dart';
import '../../domain/repositories/platform_integration_repository.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';
import 'platform_integration_data_source.dart';

class PlatformIntegrationDataSourceImpl extends BaseAudioHandler
    implements PlatformIntegrationDataSource {
  PlatformIntegrationDataSourceImpl();

  static final _log = FimberLog('PlatformIntegrationDataSourceImpl');

  final BehaviorSubject<PlatformIntegrationEvent> _eventSubject = BehaviorSubject();

  // BaseAudioHandler interface

  @override
  Future<void> play() async {
    _log.d('play');
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.play));
  }

  @override
  Future<void> pause() async {
    _log.d('pause');
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.pause));
  }

  @override
  Future<void> skipToNext() async {
    _log.d('skipToNext');
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.skipNext));
  }

  @override
  Future<void> skipToPrevious() async {
    _log.d('skipToPrevious');
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.skipPrevious));
  }

  @override
  Future<void> seek(Duration position) async {
    _log.d('skipToPrevious');
    _eventSubject.add(PlatformIntegrationEvent(
      type: PlatformIntegrationEventType.seek,
      payload: {'position': position},
    ));
  }

  // PlatformIntegrationDataSource interface

  @override
  Stream<PlatformIntegrationEvent> get eventStream => _eventSubject.stream;

  @override
  Future<void> handlePlaybackEvent(PlaybackEventModel pe) async {
    if (pe.processingState == ProcessingState.ready) {
      final timeDelta = DateTime.now().difference(pe.updateTime);
      if (pe.playing) {
        playbackState.add(playbackState.value.copyWith(
          controls: [MediaControl.skipToPrevious, MediaControl.pause, MediaControl.skipToNext],
          systemActions: const {
            MediaAction.seek,
          },
          playing: true,
          processingState: AudioProcessingState.ready,
          updatePosition: pe.updatePosition + timeDelta,
        ));
      } else {
        playbackState.add(playbackState.value.copyWith(
          controls: [MediaControl.skipToPrevious, MediaControl.play, MediaControl.skipToNext],
          systemActions: const {
            MediaAction.seek,
          },
          processingState: AudioProcessingState.ready,
          updatePosition: pe.updatePosition + timeDelta,
          playing: false,
        ));
      }
    } else if (pe.processingState == ProcessingState.completed) {
      final timeDelta = DateTime.now().difference(pe.updateTime);
      playbackState.add(playbackState.value.copyWith(
        controls: [MediaControl.skipToPrevious, MediaControl.play, MediaControl.skipToNext],
        systemActions: const {
          MediaAction.seek,
        },
        processingState: AudioProcessingState.ready,
        updatePosition: pe.updatePosition + timeDelta,
        playing: false,
      ));
    } else {
      _log.d(pe.processingState.toString());
    }
  }

  @override
  Future<void> setCurrentSong(SongModel songModel) async {
    mediaItem.add(songModel.toMediaItem());
  }
}
