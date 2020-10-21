import 'package:audio_service/audio_service.dart';

class QueueItem {
  QueueItem(this.mediaItem, {this.originalIndex, this.type = QueueItemType.standard});

  final MediaItem mediaItem;
  final int originalIndex;
  final QueueItemType type;
}

enum QueueItemType { standard, predecessor, successor }
