enum ShuffleMode {
  none,
  standard,
  plus
}

extension ShuffleModeExtension on String {
  ShuffleMode toShuffleMode() {
    switch (this) {
      case 'ShuffleMode.none':
        return ShuffleMode.none;
      case 'ShuffleMode.standard':
        return ShuffleMode.standard;
      case 'ShuffleMode.plus':
        return ShuffleMode.plus;
      default:
        // TODO: does this make sense? maybe throw an error?
        return ShuffleMode.none;
    }
  }
}