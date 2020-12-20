import 'package:just_audio/just_audio.dart' as ja;

import '../../domain/entities/playback_event.dart';

class PlaybackEventModel extends PlaybackEvent {
  PlaybackEventModel({
    Duration duration,
    int index,
    ProcessingState processingState,
    Duration updatePosition,
    DateTime updateTime,
  }) : super(
          duration: duration,
          index: index,
          processingState: processingState,
          updatePosition: updatePosition,
          updateTime: updateTime,
        );

  factory PlaybackEventModel.fromJAPlaybackEvent(ja.PlaybackEvent playbackEvent) =>
      PlaybackEventModel(
        duration: playbackEvent.duration,
        index: playbackEvent.currentIndex,
        processingState: playbackEvent.processingState.toProcessingState(),
        updatePosition: playbackEvent.updatePosition,
        updateTime: playbackEvent.updateTime,
      );
}

// extension JAProcessingStateExt on ProcessingState {
//   ProcessingState fromJAProcessingState(ja.ProcessingState processingState) {
//     switch (processingState) {
//       case ja.ProcessingState.loading:
//         return ProcessingState.loading;
//       case ja.ProcessingState.buffering:
//         return ProcessingState.buffering;
//       case ja.ProcessingState.ready:
//         return ProcessingState.ready;
//       case ja.ProcessingState.completed:
//         return ProcessingState.completed;
//       default:
//         return ProcessingState.none;
//     }
//   }
// }

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
