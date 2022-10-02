import 'package:rxdart/rxdart.dart';

import '../../domain/entities/history_entry.dart';
import '../../domain/entities/playable.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_data_source.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._historyDataSource);

  final HistoryDataSource _historyDataSource;

  @override
  Future<void> addHistoryEntry(Playable playable) async {
    if (playable.type != PlayableType.all) await _historyDataSource.addHistoryEntry(playable);
  }

  @override
  ValueStream<List<HistoryEntry>> getHistoryStream({
    int? limit,
    bool? unique = true,
    bool? includeSearch = false,
  }) {
    final valueStream = ValueConnectableStream(
      _historyDataSource.historyStream(
        limit: limit,
        unique: unique ?? true,
        includeSearch: includeSearch ?? false,
      ),
    );
    valueStream.connect();

    return valueStream;
  }
}
