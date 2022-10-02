import 'package:drift/drift.dart';

import '../../domain/entities/history_entry.dart';
import '../../domain/entities/playable.dart';
import '../datasources/moor_database.dart';

class HistoryEntryModel extends HistoryEntry {
  HistoryEntryModel({required super.time, required super.playable});

  factory HistoryEntryModel.fromMoor(MoorHistoryEntry moorHistoryEntry, Playable playable) {
    return HistoryEntryModel(
      time: moorHistoryEntry.time,
      playable: playable,
    );
  }

  HistoryEntriesCompanion toMoor() {
    return HistoryEntriesCompanion(
      time: Value(time),
      type: Value(playable.type.toString()),
      identifier: Value(playable.identifier),
    );
  }
}
