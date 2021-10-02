import '../../domain/entities/shuffle_mode.dart';


extension ShuffleModeToInt on ShuffleMode {
  int toInt() {
    switch(this) {
      case ShuffleMode.standard:
        return 1;
      case ShuffleMode.plus:
        return 2;
      default:
        return 0;
    }
  }
}

extension IntToShuffleMode on int {
  ShuffleMode toShuffleMode() {
    switch(this) {
      case 1:
        return ShuffleMode.standard;
      case 2:
        return ShuffleMode.plus;
      default:
        return ShuffleMode.none;
    }
  }
}