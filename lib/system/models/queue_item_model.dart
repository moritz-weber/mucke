import '../../domain/entities/queue_item.dart';
import 'song_model.dart';

class QueueItemModel extends QueueItem {
  QueueItemModel(
    SongModel song, {
    required int originalIndex,
    QueueItemSource source = QueueItemSource.original,
    bool isAvailable = true,
  }) : super(song, originalIndex: originalIndex, source: source, isAvailable: isAvailable);

  QueueItemModel copyWith({
    SongModel? song,
    int? originalIndex,
    QueueItemSource? type,
  }) =>
      QueueItemModel(
        song ?? this.song as SongModel,
        originalIndex: originalIndex ?? this.originalIndex,
        source: type ?? this.source,
      );
}

extension IntToQueueItemType on int {
  QueueItemSource toQueueItemType() {
    switch (this) {
      case 1:
        return QueueItemSource.predecessor;
      case 2:
        return QueueItemSource.successor;
      case 3:
        return QueueItemSource.added;
      default:
        return QueueItemSource.original;
    }
  }
}

extension QueueItemTypeToInt on QueueItemSource {
  int toInt() {
    switch (this) {
      case QueueItemSource.predecessor:
        return 1;
      case QueueItemSource.successor:
        return 2;
      case QueueItemSource.added:
        return 3;
      default:
        return 0;
    }
  }
}
