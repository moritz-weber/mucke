import 'package:mobx/mobx.dart';

import '../../../domain/entities/home_widgets/history.dart';
import '../../../domain/repositories/home_widget_repository.dart';

part 'history_form_store.g.dart';

class HistoryFormStore extends _HistoryFormStore with _$HistoryFormStore {
  HistoryFormStore({
    required HomeWidgetRepository homeWidgetRepository,
    required HomeHistory homeHistory,
  }) : super(homeWidgetRepository, homeHistory);
}

abstract class _HistoryFormStore with Store {
  _HistoryFormStore(
    this._homeWidgetRepository,
    this._history,
  );

  final HomeWidgetRepository _homeWidgetRepository;

  final HomeHistory _history;

  @observable
  late String maxEntries = _intToString(_history.maxEntries > 0 ? _history.maxEntries : 3);

  Future<void> save() async {
    _homeWidgetRepository.updateHomeWidget(
      HomeHistory(
        position: _history.position,
        maxEntries: int.parse(maxEntries),
      ),
    );
  }
}

String _intToString(int? number) {
  if (number == null) return '0';
  return number.toString();
}
