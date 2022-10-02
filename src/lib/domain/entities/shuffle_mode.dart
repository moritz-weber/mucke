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
        throw TypeError();
    }
  }
}