import 'package:just_audio/just_audio.dart' as ja;

import '../../domain/entities/player_state.dart';

class PlayerStateModel extends PlayerState {
  PlayerStateModel(bool playing, ProcessingState processingState)
      : super(playing, processingState);

  factory PlayerStateModel.fromJAPlayerState(ja.PlayerState playerState) =>
      PlayerStateModel(
        playerState.playing,
        playerState.processingState.toProcessingState(),
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
