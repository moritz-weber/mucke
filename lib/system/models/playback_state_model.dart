import 'package:audio_service/audio_service.dart';

import '../../domain/entities/playback_state.dart' as entity;

class PlaybackStateModel {

  static entity.PlaybackState fromASPlaybackState(PlaybackState playbackState) {
    if (playbackState == null) {
      return null;
    }

    switch (playbackState.basicState) {
      case BasicPlaybackState.none:
        return entity.PlaybackState.none;
      case BasicPlaybackState.stopped:
        return entity.PlaybackState.stopped;
      case BasicPlaybackState.paused:
        return entity.PlaybackState.paused;
      case BasicPlaybackState.playing:
        return entity.PlaybackState.playing;
      default:
        return entity.PlaybackState.none;
    }
  }

}
