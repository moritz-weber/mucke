import 'package:audio_service/audio_service.dart';

import '../../domain/entities/playback_state.dart' as entity;

class PlaybackStateModel {

  static entity.PlaybackState fromASPlaybackState(PlaybackState playbackState) {
    if (playbackState == null) {
      return null;
    }

    if (playbackState.playing) {
      return entity.PlaybackState.playing;
    } else if (playbackState.processingState == AudioProcessingState.ready) {
      return entity.PlaybackState.paused;
    }

    switch (playbackState.processingState) {
      case AudioProcessingState.completed:
        return entity.PlaybackState.stopped;
      default:
        return entity.PlaybackState.none;
    }
  }

}
