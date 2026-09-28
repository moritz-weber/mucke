import 'package:rxdart/rxdart.dart';

import '../entities/playable.dart';
import '../entities/queue_item.dart';

abstract class ManagedQueueInfo {
  /// The current queue as [QueueItem]s, in the order they will be played.
  List<QueueItem> get queueItems;

  ValueStream<List<QueueItem>> get queueItemsStream;
  ValueStream<List<QueueItem>> get availableSongsStream;
  ValueStream<Playable> get playableStream;
}
