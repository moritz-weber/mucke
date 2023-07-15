import 'package:just_audio/just_audio.dart' as ja;

import '../../domain/entities/loop_mode.dart';

extension LoopModeToJA on LoopMode {
  ja.LoopMode toJA() {
    switch(this) {
      case LoopMode.one:
        return ja.LoopMode.one;
      case LoopMode.all:
        return ja.LoopMode.all;
      default:
        return ja.LoopMode.off;
    }
  }
}

extension JALoopModeToEntity on ja.LoopMode {
  LoopMode toEntity() {
    switch(this) {
      case ja.LoopMode.one:
        return LoopMode.one;
      case ja.LoopMode.all:
        return LoopMode.all;
      default:
        return LoopMode.off;
    }
  }
}

extension LoopModeToInt on LoopMode {
  int toInt() {
    switch(this) {
      case LoopMode.one:
        return 1;
      case LoopMode.all:
        return 2;
      case LoopMode.stop:
        return 3;
      default:
        return 0;
    }
  }
}

extension IntToLoopMode on int {
  LoopMode toLoopMode() {
    switch(this) {
      case 1:
        return LoopMode.one;
      case 2:
        return LoopMode.all;
      case 3:
        return LoopMode.stop;
      default:
        return LoopMode.off;
    }
  }
}