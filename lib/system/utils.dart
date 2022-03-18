import '../domain/entities/playable.dart';
import '../domain/entities/shuffle_mode.dart';
import '../domain/entities/smart_list.dart';

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

int calcBlockLevel(ShuffleMode shuffleMode, Playable playable) {
  int blockLevel = 2; // exclude songs with highest block level only
  if (playable.type == PlayableType.smartlist) {
    final sl = playable as SmartList;
    return sl.filter.blockLevel;
  } else {
    if (shuffleMode != ShuffleMode.none) {
      if (playable.type == PlayableType.all) {
        blockLevel = 0; // shuffling all songs -> strictest setting
      } else {
        blockLevel = 1;
      }
    }
  }
  return blockLevel;
}
