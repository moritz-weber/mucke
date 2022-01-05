import 'package:mobx/mobx.dart';
import '../../constants.dart';

import '../../domain/entities/artist.dart';
import '../../domain/entities/smart_list.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../utils.dart';

part 'smart_list_form_store.g.dart';

class SmartListFormStore extends _SmartListStore with _$SmartListFormStore {
  SmartListFormStore({
    required MusicDataRepository musicDataRepository,
    SmartList? smartList,
  }) : super(musicDataRepository, smartList);
}

abstract class _SmartListStore with Store {
  _SmartListStore(
    this._musicDataRepository,
    this._smartList,
  );

  final MusicDataRepository _musicDataRepository;
  final SmartList? _smartList;

  final FormErrorState error = FormErrorState();

  @observable
  late String? name = _smartList?.name;

  @observable
  late int minLikeCount = _smartList?.filter.minLikeCount ?? 0;
  @observable
  late int maxLikeCount = _smartList?.filter.maxLikeCount ?? MAX_LIKE_COUNT;

  @observable
  late bool minPlayCountEnabled = _smartList?.filter.minPlayCount != null;
  @observable
  late String minPlayCount = _intToString(_smartList?.filter.minPlayCount);

  @observable
  late bool maxPlayCountEnabled = _smartList?.filter.maxPlayCount != null;
  @observable
  late String maxPlayCount = _intToString(_smartList?.filter.maxPlayCount);

  @observable
  late bool minSkipCountEnabled = _smartList?.filter.minSkipCount != null;
  @observable
  late String minSkipCount = _intToString(_smartList?.filter.minSkipCount);

  @observable
  late bool maxSkipCountEnabled = _smartList?.filter.maxSkipCount != null;
  @observable
  late String maxSkipCount = _intToString(_smartList?.filter.maxSkipCount);

  @observable
  late bool minYearEnabled = _smartList?.filter.minYear != null;
  @observable
  late String minYear = _intToString(_smartList?.filter.minYear);

  @observable
  late bool maxYearEnabled = _smartList?.filter.maxYear != null;
  @observable
  late String maxYear = _intToString(_smartList?.filter.maxYear);

  @observable
  late bool limitEnabled = _smartList?.filter.limit != null;
  @observable
  late String limit = _intToString(_smartList?.filter.limit);

  @observable
  late int blockLevel = _smartList?.filter.blockLevel ?? 0;

  @observable
  late ObservableSet<Artist> selectedArtists =
      (_smartList?.filter.artists.toSet() ?? {}).asObservable();
  @observable
  late bool excludeArtists = _smartList?.filter.excludeArtists ?? false;

  @observable
  late ObservableList<OrderEntry> orderState =
      _createOrderState(_smartList?.orderBy).asObservable();

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

  @action
  void addArtist(Artist artist) {
    selectedArtists.add(artist);
    print(selectedArtists);
  }

  @action
  void removeArtist(Artist artist) {
    selectedArtists.remove(artist);
    print(selectedArtists);
  }

  Future<void> save() async {
    if (_smartList == null) {
      _createSmartList();
    } else {
      _updateSmartList();
    }
  }

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => name, _validateName),
      reaction((_) => minPlayCount, (String n) => _validateMinPlayCount(minPlayCountEnabled, n)),
      reaction((_) => maxPlayCount, (String n) => _validateMaxPlayCount(maxPlayCountEnabled, n)),
      reaction((_) => minSkipCount, (String n) => _validateMinSkipCount(minSkipCountEnabled, n)),
      reaction((_) => maxSkipCount, (String n) => _validateMaxSkipCount(maxSkipCountEnabled, n)),
      reaction((_) => minYear, (String n) => _validateMinYear(minYearEnabled, n)),
      reaction((_) => maxYear, (String n) => _validateMaxYear(maxYearEnabled, n)),
      reaction((_) => limit, (String n) => _validateLimit(limitEnabled, n)),
      reaction((_) => selectedArtists, (_) => print(selectedArtists)),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    _validateName(name);
    _validateMinPlayCount(minPlayCountEnabled, minPlayCount);
    _validateMaxPlayCount(maxPlayCountEnabled, maxPlayCount);
    _validateMinSkipCount(minSkipCountEnabled, minSkipCount);
    _validateMaxSkipCount(maxSkipCountEnabled, maxSkipCount);
    _validateMinYear(minYearEnabled, minYear);
    _validateMaxYear(maxYearEnabled, maxYear);
    _validateLimit(limitEnabled, limit);
  }

  void _validateName(String? name) {
    error.name = name == null || name == '' ? 'The name must not be empty.' : null;
  }

  void _validateMinPlayCount(bool enabled, String number) {
    error.minPlayCount = validateNumber(enabled, number);
  }

  void _validateMaxPlayCount(bool enabled, String number) {
    error.maxPlayCount = validateNumber(enabled, number);
  }

  void _validateMinSkipCount(bool enabled, String number) {
    error.minSkipCount = validateNumber(enabled, number);
  }

  void _validateMaxSkipCount(bool enabled, String number) {
    error.maxSkipCount = validateNumber(enabled, number);
  }

  void _validateMinYear(bool enabled, String number) {
    error.minYear = validateNumber(enabled, number);
  }

  void _validateMaxYear(bool enabled, String number) {
    error.maxYear = validateNumber(enabled, number);
  }

  void _validateLimit(bool enabled, String number) {
    error.limit = validateNumber(enabled, number);
  }

  

  Future<void> _createSmartList() async {
    await _musicDataRepository.insertSmartList(
      name: name ?? 'This needs a name',
      filter: Filter(
        artists: selectedArtists.toList(),
        excludeArtists: excludeArtists,
        minPlayCount: minPlayCountEnabled ? int.tryParse(minPlayCount) : null,
        maxPlayCount: maxPlayCountEnabled ? int.tryParse(maxPlayCount) : null,
        minSkipCount: minSkipCountEnabled ? int.tryParse(minSkipCount) : null,
        maxSkipCount: maxSkipCountEnabled ? int.tryParse(maxSkipCount) : null,
        minYear: minYearEnabled ? int.tryParse(minYear) : null,
        maxYear: maxYearEnabled ? int.tryParse(maxYear) : null,
        minLikeCount: minLikeCount,
        maxLikeCount: maxLikeCount,
        blockLevel: blockLevel,
        limit: limitEnabled ? int.tryParse(limit) : null,
      ),
      orderBy: OrderBy(
        orderCriteria: orderState.where((e) => e.enabled).map((e) => e.orderCriterion).toList(),
        orderDirections: orderState.where((e) => e.enabled).map((e) => e.orderDirection).toList(),
      ),
    );
  }

  Future<void> _updateSmartList() async {
    await _musicDataRepository.updateSmartList(
      SmartList(
        id: _smartList!.id,
        name: name ?? 'This needs a name',
        filter: Filter(
          artists: selectedArtists.toList(),
          excludeArtists: excludeArtists,
          minPlayCount: minPlayCountEnabled ? int.tryParse(minPlayCount) : null,
          maxPlayCount: maxPlayCountEnabled ? int.tryParse(maxPlayCount) : null,
          minSkipCount: minSkipCountEnabled ? int.tryParse(minSkipCount) : null,
          maxSkipCount: maxSkipCountEnabled ? int.tryParse(maxSkipCount) : null,
          minYear: minYearEnabled ? int.tryParse(minYear) : null,
          maxYear: maxYearEnabled ? int.tryParse(maxYear) : null,
          minLikeCount: minLikeCount,
          maxLikeCount: maxLikeCount,
          blockLevel: blockLevel,
          limit: limitEnabled ? int.tryParse(limit) : null,
        ),
        orderBy: OrderBy(
          orderCriteria: orderState.where((e) => e.enabled).map((e) => e.orderCriterion).toList(),
          orderDirections: orderState.where((e) => e.enabled).map((e) => e.orderDirection).toList(),
        ),
      ),
    );
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? name;

  @observable
  String? minPlayCount;

  @observable
  String? maxPlayCount;

  @observable
  String? minSkipCount;

  @observable
  String? maxSkipCount;

  @observable
  String? minYear;

  @observable
  String? maxYear;

  @observable
  String? limit;

  @computed
  bool get hasErrors =>
      name != null ||
      minPlayCount != null ||
      maxPlayCount != null ||
      minYear != null ||
      maxYear != null ||
      limit != null;
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
    OrderCriterion.skipCount: 'Skip count',
    OrderCriterion.artistName: 'Artist name',
    OrderCriterion.year: 'Year',
    OrderCriterion.timeAdded: 'Time added',
  };

  final defaultState = [
    OrderEntry(false, OrderCriterion.songTitle, OrderDirection.ascending,
        descriptions[OrderCriterion.songTitle]!),
    OrderEntry(false, OrderCriterion.likeCount, OrderDirection.ascending,
        descriptions[OrderCriterion.likeCount]!),
    OrderEntry(false, OrderCriterion.playCount, OrderDirection.ascending,
        descriptions[OrderCriterion.playCount]!),
    OrderEntry(false, OrderCriterion.skipCount, OrderDirection.ascending,
        descriptions[OrderCriterion.skipCount]!),
    OrderEntry(false, OrderCriterion.artistName, OrderDirection.ascending,
        descriptions[OrderCriterion.artistName]!),
    OrderEntry(
        false, OrderCriterion.year, OrderDirection.ascending, descriptions[OrderCriterion.year]!),
    OrderEntry(false, OrderCriterion.timeAdded, OrderDirection.ascending,
        descriptions[OrderCriterion.timeAdded]!),
  ];

  if (orderBy == null) {
    return defaultState;
  } else {
    final orderState = <OrderEntry>[];
    for (int i = 0; i < orderBy.orderCriteria.length; i++) {
      final criterion = orderBy.orderCriteria[i];
      orderState
          .add(OrderEntry(true, criterion, orderBy.orderDirections[i], descriptions[criterion]!));
      defaultState.removeWhere((entry) => entry.orderCriterion == criterion);
    }

    return orderState + defaultState;
  }
}

String _intToString(int? number) {
  if (number == null) return '0';
  return number.toString();
}
