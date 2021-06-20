import 'song.dart';

class QueueItem {
  QueueItem(
    this.song, {
    required this.originalIndex,
    this.type = QueueItemType.standard,
  });

  final Song song;
  final int originalIndex;
  final QueueItemType type;

  @override
  String toString() {
    return '${song.title}';
  }
}

enum QueueItemType { standard, predecessor, successor, added }
