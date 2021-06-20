import 'package:just_audio/just_audio.dart' as ja;

import '../../domain/entities/playback_event.dart';

class PlaybackEventModel extends PlaybackEvent {
  PlaybackEventModel({
    required int index,
    required bool playing,
    required ProcessingState processingState,
    required Duration updatePosition,
    required DateTime updateTime,
  }) : super(
          index: index,
          playing: playing,
          processingState: processingState,
          updatePosition: updatePosition,
          updateTime: updateTime,
        );

  factory PlaybackEventModel.fromJAPlaybackEvent(ja.PlaybackEvent playbackEvent, bool playing) =>
      PlaybackEventModel(
        index: playbackEvent.currentIndex ?? -1,
        playing: playing,
        processingState: playbackEvent.processingState.toProcessingState(),
        updatePosition: playbackEvent.updatePosition,
        updateTime: playbackEvent.updateTime,
      );
}

extension ProcessingStateExt on ja.ProcessingState {
  ProcessingState toProcessingState() {
    switch (this) {
      case ja.ProcessingState.loading:
        return ProcessingState.loading;
      case ja.ProcessingState.buffering:
        return ProcessingState.buffering;
      case ja.ProcessingState.ready:
        return ProcessingState.ready;
      case ja.ProcessingState.completed:
        return ProcessingState.completed;
      default:
        return ProcessingState.none;
    }
  }
}
