import 'package:mobx/mobx.dart';

import '../../domain/entities/smart_list.dart';
import '../../domain/repositories/settings_repository.dart';

part 'smart_list_form_store.g.dart';

class SmartListFormStore extends _SmartListStore with _$SmartListFormStore {
  SmartListFormStore({
    required SettingsRepository settingsRepository,
    SmartList? smartList,
  }) : super(settingsRepository, smartList);
}

abstract class _SmartListStore with Store {
  _SmartListStore(
    this._settingsRepository,
    this._smartList,
  );

  final SettingsRepository _settingsRepository;
  final SmartList? _smartList;

  // evtl als computed aus _smartList -> würde save auch leichter machen?
  @observable
  late String? name = _smartList?.name;

  @observable
  late int minLikeCount = _smartList?.filter.minLikeCount ?? 0;
  @observable
  late int maxLikeCount = _smartList?.filter.maxLikeCount ?? 5;

  @observable
  late bool minPlayCountEnabled = _smartList?.filter.minPlayCount != null;
  @observable
  late String minPlayCount = _smartList?.filter.minPlayCount.toString() ?? '0';

  @observable
  late bool maxPlayCountEnabled = _smartList?.filter.maxPlayCount != null;
  @observable
  late int maxPlayCount = _smartList?.filter.maxPlayCount ?? 0;

  @observable
  late bool limitEnabled = _smartList?.filter.limit != null;
  @observable
  late int limit = _smartList?.filter.limit ?? 0;

  @observable
  late ObservableList<OrderEntry> orderState =
      _createOrderState(_smartList?.orderBy).asObservable();

  void dispose() {}

  @action
  void setOrderEnabled(int index, bool enabled) {
    final os = orderState[index];
    orderState[index] = OrderEntry(enabled, os.orderCriterion, os.orderDirection, os.text);
  }

  @action
  void toggleOrderDirection(int index) {
    final os = orderState[index];
    final direction = os.orderDirection == OrderDirection.ascending
        ? OrderDirection.descending
        : OrderDirection.ascending;
    orderState[index] = OrderEntry(os.enabled, os.orderCriterion, direction, os.text);
  }

  @action
  void reorderOrderState(int oldIndex, int newIndex) {
    final tmp = orderState.removeAt(oldIndex);
    orderState.insert(newIndex, tmp);
  }

  Future<void> save() async {
    if (_smartList == null) {
      _createSmartList();
    } else {
      _updateSmartList();
    }
  }

  Future<void> _createSmartList() async {
    await _settingsRepository.insertSmartList(
      SmartList(
        name: name ?? 'This needs a name',
        position: -1,
        filter: Filter(
          artists: const [],
          excludeArtists: false,
          minPlayCount: minPlayCountEnabled ? int.tryParse(minPlayCount) : null,
          maxPlayCount: maxPlayCountEnabled ? maxPlayCount : null,
          minLikeCount: minLikeCount,
          maxLikeCount: maxLikeCount,
          limit: limitEnabled ? limit : null,
        ),
        orderBy: OrderBy(
          orderCriteria: orderState.where((e) => e.enabled).map((e) => e.orderCriterion).toList(),
          orderDirections: orderState.where((e) => e.enabled).map((e) => e.orderDirection).toList(),
        ),
      ),
    );
  }

  Future<void> _updateSmartList() async {
    await _settingsRepository.updateSmartList(
      SmartList(
        id: _smartList!.id,
        name: name ?? 'This needs a name',
        position: _smartList!.position,
        filter: Filter(
          artists: const [],
          excludeArtists: false,
          minPlayCount: minPlayCountEnabled ? int.tryParse(minPlayCount) : null,
          maxPlayCount: maxPlayCountEnabled ? maxPlayCount : null,
          minLikeCount: minLikeCount,
          maxLikeCount: maxLikeCount,
          limit: limitEnabled ? limit : null,
        ),
        orderBy: OrderBy(
          orderCriteria: orderState.where((e) => e.enabled).map((e) => e.orderCriterion).toList(),
          orderDirections: orderState.where((e) => e.enabled).map((e) => e.orderDirection).toList(),
        ),
      ),
    );
  }
}

class OrderEntry {
  OrderEntry(
    this.enabled,
    this.orderCriterion,
    this.orderDirection,
    this.text,
  );

  final bool enabled;
  final OrderCriterion orderCriterion;
  final OrderDirection orderDirection;
  final String text;
}

List<OrderEntry> _createOrderState(OrderBy? orderBy) {
  final descriptions = {
    OrderCriterion.songTitle: 'Song title',
    OrderCriterion.likeCount: 'Like count',
    OrderCriterion.playCount: 'Play count',
    OrderCriterion.artistName: 'Artist name',
  };

  final defaultState = [
    OrderEntry(false, OrderCriterion.songTitle, OrderDirection.ascending,
        descriptions[OrderCriterion.songTitle]!),
    OrderEntry(false, OrderCriterion.likeCount, OrderDirection.ascending,
        descriptions[OrderCriterion.likeCount]!),
    OrderEntry(false, OrderCriterion.playCount, OrderDirection.ascending,
        descriptions[OrderCriterion.playCount]!),
    OrderEntry(false, OrderCriterion.artistName, OrderDirection.ascending,
        descriptions[OrderCriterion.artistName]!),
  ];

  if (orderBy == null) {
    return defaultState;
  } else {
    final orderState = <OrderEntry>[];
    for (int i = 0; i < orderBy.orderCriteria.length; i++) {
      final criterion = orderBy.orderCriteria[i];
      orderState.add(OrderEntry(true, criterion, orderBy.orderDirections[i], descriptions[criterion]!));
      defaultState.removeWhere((entry) => entry.orderCriterion == criterion);
    }

    return orderState + defaultState;
  }
}
