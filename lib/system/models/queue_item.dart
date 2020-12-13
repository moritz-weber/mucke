import 'song_model.dart';

class QueueItem {
  QueueItem(
    this.song, {
    this.originalIndex,
    this.type = QueueItemType.standard,
  });

  final SongModel song;
  final int originalIndex;
  final QueueItemType type;
}

enum QueueItemType { standard, predecessor, successor, added }
