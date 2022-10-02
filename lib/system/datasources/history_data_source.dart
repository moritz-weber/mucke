import '../../domain/entities/playable.dart';
import '../models/history_entry_model.dart';

abstract class HistoryDataSource {
  Stream<List<HistoryEntryModel>> historyStream({int? limit, required bool unique, required bool includeSearch});
  Future<void> addHistoryEntry(Playable playable);
}