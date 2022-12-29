import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/playback_event.dart';
import '../../domain/repositories/platform_integration_repository.dart';
import '../models/playback_event_model.dart';
import '../models/song_model.dart';
import 'platform_integration_data_source.dart';

const favs = [
  MediaControl(
    androidIcon: 'drawable/favorite_0',
    label: 'Like',
    action: MediaAction.rewind,
  ),
  MediaControl(
    androidIcon: 'drawable/favorite_1',
    label: 'Like',
    action: MediaAction.rewind,
  ),
  MediaControl(
    androidIcon: 'drawable/favorite_2',
    label: 'Like',
    action: MediaAction.rewind,
  ),
  MediaControl(
    androidIcon: 'drawable/favorite_3',
    label: 'Like',
    action: MediaAction.rewind,
  ),
];

const playCtrl = MediaControl(
  androidIcon: 'drawable/play',
  label: 'Play',
  action: MediaAction.play,
);
const pauseCtrl = MediaControl(
  androidIcon: 'drawable/pause',
  label: 'Pause',
  action: MediaAction.pause,
);
const nextCtrl = MediaControl(
  androidIcon: 'drawable/skip_next',
  label: 'Next',
  action: MediaAction.skipToNext,
);
const prevCtrl = MediaControl(
  androidIcon: 'drawable/skip_prev',
  label: 'Previous',
  action: MediaAction.skipToPrevious,
);

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
  Future<void> rewind() async {
    _log.d('rewind -> like');
    _eventSubject.add(PlatformIntegrationEvent(
        type: PlatformIntegrationEventType.like, payload: {'path': mediaItem.value?.id}));
  }

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {
    _log.i(button.toString());
    final session = await AudioSession.instance;

    switch (button) {
      case MediaButton.media:
        if (!playbackState.value.playing) {
          await play();
        } else {
          // When connecting to certain Bluetooth devices via NFC, this button gets "clicked".
          // In order to keep the music playing when connecting, we ignore this
          // if there is no device connected that could trigger this button press.
          // Listening to device changes would be nicer, but we get them only after this click (up to 1s delay).
          final devices = _filterAudioDevices(await session.getDevices(includeInputs: false));

          if (devices.isNotEmpty) {
            await pause();
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
    final mi = mediaItem.value;
    final int likeCount = mi == null ? 0 : mi.extras!['likeCount'] as int;

    if (pe.processingState == ProcessingState.ready) {
      final timeDelta = DateTime.now().difference(pe.updateTime);
      if (pe.playing) {
        playbackState.add(playbackState.value.copyWith(
          controls: [favs[likeCount], prevCtrl, pauseCtrl, nextCtrl],
          systemActions: const {
            MediaAction.seek,
          },
          playing: true,
          processingState: AudioProcessingState.ready,
          updatePosition: pe.updatePosition + timeDelta,
          androidCompactActionIndices: [0, 2, 3],
        ));
      } else {
        playbackState.add(playbackState.value.copyWith(
          controls: [favs[likeCount], prevCtrl, playCtrl, nextCtrl],
          systemActions: const {
            MediaAction.seek,
          },
          processingState: AudioProcessingState.ready,
          updatePosition: pe.updatePosition + timeDelta,
          playing: false,
          androidCompactActionIndices: [0, 2, 3],
        ));
      }
    } else if (pe.processingState == ProcessingState.completed) {
      final timeDelta = DateTime.now().difference(pe.updateTime);
      playbackState.add(playbackState.value.copyWith(
        controls: [favs[likeCount], prevCtrl, playCtrl, nextCtrl],
        systemActions: const {
          MediaAction.seek,
        },
        processingState: AudioProcessingState.ready,
        updatePosition: pe.updatePosition + timeDelta,
        playing: false,
        androidCompactActionIndices: [0, 2, 3],
      ));
    } else if (pe.processingState == ProcessingState.none) {
      stop();
    } else {
      _log.d(pe.processingState.toString());
    }
  }

  @override
  Future<void> setCurrentSong(SongModel? songModel) async {
    mediaItem.add(songModel?.toMediaItem());

    if (songModel != null) {
      final state = playbackState.value;
      final controls = state.controls.sublist(1);
      final timeDelta = state.playing ? DateTime.now().difference(state.updateTime) : Duration.zero;

      playbackState.add(playbackState.value.copyWith(
        controls: [favs[songModel.likeCount]] + controls,
        updatePosition: state.updatePosition + timeDelta,
      ));
    }
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
