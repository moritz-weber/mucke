import 'package:rxdart/rxdart.dart';

import '../entities/history_entry.dart';
import '../entities/playable.dart';

abstract class HistoryRepository {
  ValueStream<List<HistoryEntry>> getHistoryStream({int? limit, bool? unique, bool? includeSearch});
  Future<void> addHistoryEntry(Playable playable);
}
