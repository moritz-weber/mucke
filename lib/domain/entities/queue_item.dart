import 'song.dart';

class QueueItem {
  QueueItem(
    this.song, {
    required this.originalIndex,
    this.source = QueueItemSource.original,
    required this.isAvailable,
  });

  Song song;
  int originalIndex;
  QueueItemSource source;
  bool isAvailable;

  @override
  String toString() {
    return '${song.title}';
  }
}

enum QueueItemSource { original, predecessor, successor, added }
