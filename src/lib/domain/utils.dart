import 'entities/playable.dart';
import 'entities/queue_item.dart';
import 'entities/shuffle_mode.dart';
import 'entities/smart_list.dart';

List<QueueItem> filterAvailableSongs(
  List<QueueItem> availableSongs, {
  bool keepIndex = false,
  List<int> indices = const [],
  required int blockLevel,
}) {
  final List<QueueItem> result = [];

  final kIndices = keepIndex ? indices : <int>[];
  for (int i = 0; i < availableSongs.length; i++) {
    final qi = availableSongs[i];
    if (kIndices.contains(i) || (qi.song.blockLevel <= blockLevel && qi.isAvailable)) {
      result.add(qi);
    }
  }

  return result;
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
