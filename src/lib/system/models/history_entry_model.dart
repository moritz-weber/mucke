import 'package:drift/drift.dart';

import '../../domain/entities/history_entry.dart';
import '../../domain/entities/playable.dart';
import '../datasources/drift_database.dart';

class HistoryEntryModel extends HistoryEntry {
  HistoryEntryModel({required super.time, required super.playable});

  factory HistoryEntryModel.fromDrift(DriftHistoryEntry driftHistoryEntry, Playable playable) {
    return HistoryEntryModel(
      time: driftHistoryEntry.time,
      playable: playable,
    );
  }

  HistoryEntriesCompanion toDrift() {
    return HistoryEntriesCompanion(
      time: Value(time),
      type: Value(playable.type.toString()),
      identifier: Value(playable.identifier),
    );
  }
}
