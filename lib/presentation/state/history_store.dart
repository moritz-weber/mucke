import 'package:mobx/mobx.dart';

import '../../domain/entities/history_entry.dart';
import '../../domain/repositories/history_repository.dart';

part 'history_store.g.dart';

class HistoryStore extends _HistoryStore with _$HistoryStore {
  HistoryStore({
    required HistoryRepository historyRepository,
  }) : super(historyRepository);
}

abstract class _HistoryStore with Store {
  _HistoryStore(
    this._historyRepository,
  );

  final HistoryRepository _historyRepository;

  @observable
  late ObservableStream<List<HistoryEntry>> historyStream = _historyRepository
      .getHistoryStream(limit: 5, unique: true, includeSearch: false)
      .asObservable();

  ObservableStream<List<HistoryEntry>> getHistoryStream(int limit) {
    return _historyRepository
        .getHistoryStream(limit: limit, unique: true, includeSearch: false)
        .asObservable();
  }
}
