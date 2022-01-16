import '../domain/entities/playable.dart';
import '../domain/entities/shuffle_mode.dart';

int? parseYear(String? yearString) {
  if (yearString == null || yearString == '') {
    return null;
  }

  try {
    return int.parse(yearString);
  } on FormatException {
    return int.parse(yearString.split('-')[0]);
  }
}

int calcBlockLevel(ShuffleMode shuffleMode, PlayableType playableType) {
  int blockLevel = 2; // exclude songs with highest block level only
  if (shuffleMode != ShuffleMode.none) {
    if (playableType == PlayableType.all) {
      blockLevel = 0; // shuffling all songs -> strictest setting
    } else {
      blockLevel = 1;
    }
  }
  return blockLevel;
}
