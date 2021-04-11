import 'package:audio_service/audio_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/playback_event.dart';
import '../../domain/repositories/platform_integration_repository.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';
import 'platform_integration_data_source.dart';

class PlatformIntegrationDataSourceImpl extends BaseAudioHandler
    implements PlatformIntegrationDataSource {
  PlatformIntegrationDataSourceImpl();

  final BehaviorSubject<PlatformIntegrationEvent> _eventSubject = BehaviorSubject();

  // BaseAudioHandler interface

  @override
  Future<void> play() async {
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.play));
  }

  @override
  Future<void> pause() async {
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.pause));
  }

  @override
  Future<void> skipToNext() async {
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.skipNext));
  }

  @override
  Future<void> skipToPrevious() async {
    _eventSubject.add(PlatformIntegrationEvent(type: PlatformIntegrationEventType.skipPrevious));
  }

  // PlatformIntegrationDataSource interface

  @override
  Stream<PlatformIntegrationEvent> get eventStream => _eventSubject.stream;

  @override
  Future<void> handlePlaybackEvent(PlaybackEventModel pe) async {
    if (pe.processingState == ProcessingState.ready) {
      final timeDelta = DateTime.now().difference(pe.updateTime);
      print(timeDelta);
      if (pe.playing) {
        playbackState.add(playbackState.value.copyWith(
          controls: [MediaControl.skipToPrevious, MediaControl.pause, MediaControl.skipToNext],
          playing: true,
          processingState: AudioProcessingState.ready,
          updatePosition: pe.updatePosition + timeDelta,
        ));
      } else {
        playbackState.add(playbackState.value.copyWith(
          controls: [MediaControl.skipToPrevious, MediaControl.play, MediaControl.skipToNext],
          processingState: AudioProcessingState.ready,
          updatePosition: pe.updatePosition + timeDelta,
          playing: false,
        ));
      }
    }
  }

  @override
  Future<void> onPlay() async {
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.skipToPrevious, MediaControl.pause, MediaControl.skipToNext],
      playing: true,
      processingState: AudioProcessingState.ready,
    ));
  }

  @override
  Future<void> onPause() async {
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.skipToPrevious, MediaControl.play, MediaControl.skipToNext],
      processingState: AudioProcessingState.ready,
      playing: false,
    ));
  }

  @override
  Future<void> setCurrentSong(SongModel songModel) async {
    mediaItem.add(songModel.toMediaItem());
  }
}
