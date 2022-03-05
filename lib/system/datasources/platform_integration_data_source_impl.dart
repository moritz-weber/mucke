import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
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

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {
    final session = await AudioSession.instance;

    switch (button) {
      case MediaButton.media:
        // when connecting to certain bluetooth devices via NFC, this button gets "clicked"
        // in order to keep the music playing when connecting, we ignore this
        // if there is no device connected that could trigger this button press
        // listening to device changes would be nicer, but we get them only after this click
        final devices = _filterAudioDevices(await session.getDevices(includeInputs: false));
        if (devices.isNotEmpty) {
          if (playbackState.value.playing == true) {
            await pause();
          } else {
            await play();
          }
        }
        break;
      case MediaButton.next:
        await skipToNext();
        break;
      case MediaButton.previous:
        await skipToPrevious();
        break;
    }
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

Set<AudioDevice> _filterAudioDevices(Set<AudioDevice> devices) {
  // remove builtin outputs from list
  final result = <AudioDevice>{};

  for (final d in devices) {
    if (d.type != AudioDeviceType.builtInEarpiece &&
        d.type != AudioDeviceType.builtInSpeaker &&
        d.type != AudioDeviceType.builtInSpeakerSafe &&
        d.type != AudioDeviceType.telephony) {
      result.add(d);
    }
  }

  return result;
}
