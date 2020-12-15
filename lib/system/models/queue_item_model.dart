import '../../domain/entities/queue_item.dart';
import 'song_model.dart';

class QueueItemModel extends QueueItem {
  QueueItemModel(
    this.song, {
    int originalIndex,
    QueueItemType type = QueueItemType.standard,
  }) : super(song, originalIndex: originalIndex, type: type);

  @override
  SongModel song;
}

extension IntToQueueItemType on int {
  QueueItemType toQueueItemType() {
    switch(this) {
      case 1: return QueueItemType.predecessor;
      case 2: return QueueItemType.successor;
      case 3: return QueueItemType.added;
      default: return QueueItemType.standard;
    }
  }
}

extension QueueItemTypeToInt on QueueItemType {
  int toInt() {
    switch(this) {
      case QueueItemType.predecessor: 
        return 1;
      case QueueItemType.successor:
        return 2;
      case QueueItemType.added:
        return 3;
      default: return 0;
    }
  }
}