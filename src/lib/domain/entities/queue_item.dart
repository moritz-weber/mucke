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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueItem &&
          runtimeType == other.runtimeType &&
          song.path == other.song.path &&
          originalIndex == other.originalIndex &&
          source == other.source &&
          isAvailable == other.isAvailable;

  @override
  int get hashCode =>
      song.path.hashCode ^ originalIndex.hashCode ^ source.hashCode ^ isAvailable.hashCode;
}

enum QueueItemSource { original, predecessor, successor, added }
