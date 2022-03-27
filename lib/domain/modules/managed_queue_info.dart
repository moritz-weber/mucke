import 'package:rxdart/rxdart.dart';

import '../entities/playable.dart';
import '../entities/queue_item.dart';

abstract class ManagedQueueInfo {
  ValueStream<List<QueueItem>> get queueItemsStream;
  ValueStream<List<QueueItem>> get availableSongsStream;
  ValueStream<Playable> get playableStream;
}
