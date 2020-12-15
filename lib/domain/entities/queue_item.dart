import 'song.dart';

class QueueItem {
  QueueItem(
    this.song, {
    this.originalIndex,
    this.type = QueueItemType.standard,
  });

  final Song song;
  final int originalIndex;
  final QueueItemType type;
}

enum QueueItemType { standard, predecessor, successor, added }
