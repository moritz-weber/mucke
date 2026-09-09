// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_list_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SmartListFormStore on _SmartListStore, Store {
  Computed<int>? _$shuffleModeIndexComputed;

  @override
  int get shuffleModeIndex => (_$shuffleModeIndexComputed ??= Computed<int>(
          () => super.shuffleModeIndex,
          name: '_SmartListStore.shuffleModeIndex'))
      .value;

  late final _$nameAtom = Atom(name: '_SmartListStore.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  bool _nameIsInitialized = false;

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, _nameIsInitialized ? super.name : null, () {
      super.name = value;
      _nameIsInitialized = true;
    });
  }

  late final _$minLikeCountAtom =
      Atom(name: '_SmartListStore.minLikeCount', context: context);

  @override
  int get minLikeCount {
    _$minLikeCountAtom.reportRead();
    return super.minLikeCount;
  }

  bool _minLikeCountIsInitialized = false;

  @override
  set minLikeCount(int value) {
    _$minLikeCountAtom.reportWrite(
        value, _minLikeCountIsInitialized ? super.minLikeCount : null, () {
      super.minLikeCount = value;
      _minLikeCountIsInitialized = true;
    });
  }

  late final _$maxLikeCountAtom =
      Atom(name: '_SmartListStore.maxLikeCount', context: context);

  @override
  int get maxLikeCount {
    _$maxLikeCountAtom.reportRead();
    return super.maxLikeCount;
  }

  bool _maxLikeCountIsInitialized = false;

  @override
  set maxLikeCount(int value) {
    _$maxLikeCountAtom.reportWrite(
        value, _maxLikeCountIsInitialized ? super.maxLikeCount : null, () {
      super.maxLikeCount = value;
      _maxLikeCountIsInitialized = true;
    });
  }

  late final _$minPlayCountEnabledAtom =
      Atom(name: '_SmartListStore.minPlayCountEnabled', context: context);

  @override
  bool get minPlayCountEnabled {
    _$minPlayCountEnabledAtom.reportRead();
    return super.minPlayCountEnabled;
  }

  bool _minPlayCountEnabledIsInitialized = false;

  @override
  set minPlayCountEnabled(bool value) {
    _$minPlayCountEnabledAtom.reportWrite(value,
        _minPlayCountEnabledIsInitialized ? super.minPlayCountEnabled : null,
        () {
      super.minPlayCountEnabled = value;
      _minPlayCountEnabledIsInitialized = true;
    });
  }

  late final _$minPlayCountAtom =
      Atom(name: '_SmartListStore.minPlayCount', context: context);

  @override
  String get minPlayCount {
    _$minPlayCountAtom.reportRead();
    return super.minPlayCount;
  }

  bool _minPlayCountIsInitialized = false;

  @override
  set minPlayCount(String value) {
    _$minPlayCountAtom.reportWrite(
        value, _minPlayCountIsInitialized ? super.minPlayCount : null, () {
      super.minPlayCount = value;
      _minPlayCountIsInitialized = true;
    });
  }

  late final _$maxPlayCountEnabledAtom =
      Atom(name: '_SmartListStore.maxPlayCountEnabled', context: context);

  @override
  bool get maxPlayCountEnabled {
    _$maxPlayCountEnabledAtom.reportRead();
    return super.maxPlayCountEnabled;
  }

  bool _maxPlayCountEnabledIsInitialized = false;

  @override
  set maxPlayCountEnabled(bool value) {
    _$maxPlayCountEnabledAtom.reportWrite(value,
        _maxPlayCountEnabledIsInitialized ? super.maxPlayCountEnabled : null,
        () {
      super.maxPlayCountEnabled = value;
      _maxPlayCountEnabledIsInitialized = true;
    });
  }

  late final _$maxPlayCountAtom =
      Atom(name: '_SmartListStore.maxPlayCount', context: context);

  @override
  String get maxPlayCount {
    _$maxPlayCountAtom.reportRead();
    return super.maxPlayCount;
  }

  bool _maxPlayCountIsInitialized = false;

  @override
  set maxPlayCount(String value) {
    _$maxPlayCountAtom.reportWrite(
        value, _maxPlayCountIsInitialized ? super.maxPlayCount : null, () {
      super.maxPlayCount = value;
      _maxPlayCountIsInitialized = true;
    });
  }

  late final _$minYearEnabledAtom =
      Atom(name: '_SmartListStore.minYearEnabled', context: context);

  @override
  bool get minYearEnabled {
    _$minYearEnabledAtom.reportRead();
    return super.minYearEnabled;
  }

  bool _minYearEnabledIsInitialized = false;

  @override
  set minYearEnabled(bool value) {
    _$minYearEnabledAtom.reportWrite(
        value, _minYearEnabledIsInitialized ? super.minYearEnabled : null, () {
      super.minYearEnabled = value;
      _minYearEnabledIsInitialized = true;
    });
  }

  late final _$minYearAtom =
      Atom(name: '_SmartListStore.minYear', context: context);

  @override
  String get minYear {
    _$minYearAtom.reportRead();
    return super.minYear;
  }

  bool _minYearIsInitialized = false;

  @override
  set minYear(String value) {
    _$minYearAtom
        .reportWrite(value, _minYearIsInitialized ? super.minYear : null, () {
      super.minYear = value;
      _minYearIsInitialized = true;
    });
  }

  late final _$maxYearEnabledAtom =
      Atom(name: '_SmartListStore.maxYearEnabled', context: context);

  @override
  bool get maxYearEnabled {
    _$maxYearEnabledAtom.reportRead();
    return super.maxYearEnabled;
  }

  bool _maxYearEnabledIsInitialized = false;

  @override
  set maxYearEnabled(bool value) {
    _$maxYearEnabledAtom.reportWrite(
        value, _maxYearEnabledIsInitialized ? super.maxYearEnabled : null, () {
      super.maxYearEnabled = value;
      _maxYearEnabledIsInitialized = true;
    });
  }

  late final _$maxYearAtom =
      Atom(name: '_SmartListStore.maxYear', context: context);

  @override
  String get maxYear {
    _$maxYearAtom.reportRead();
    return super.maxYear;
  }

  bool _maxYearIsInitialized = false;

  @override
  set maxYear(String value) {
    _$maxYearAtom
        .reportWrite(value, _maxYearIsInitialized ? super.maxYear : null, () {
      super.maxYear = value;
      _maxYearIsInitialized = true;
    });
  }

  late final _$limitEnabledAtom =
      Atom(name: '_SmartListStore.limitEnabled', context: context);

  @override
  bool get limitEnabled {
    _$limitEnabledAtom.reportRead();
    return super.limitEnabled;
  }

  bool _limitEnabledIsInitialized = false;

  @override
  set limitEnabled(bool value) {
    _$limitEnabledAtom.reportWrite(
        value, _limitEnabledIsInitialized ? super.limitEnabled : null, () {
      super.limitEnabled = value;
      _limitEnabledIsInitialized = true;
    });
  }

  late final _$limitAtom =
      Atom(name: '_SmartListStore.limit', context: context);

  @override
  String get limit {
    _$limitAtom.reportRead();
    return super.limit;
  }

  bool _limitIsInitialized = false;

  @override
  set limit(String value) {
    _$limitAtom.reportWrite(value, _limitIsInitialized ? super.limit : null,
        () {
      super.limit = value;
      _limitIsInitialized = true;
    });
  }

  late final _$blockLevelAtom =
      Atom(name: '_SmartListStore.blockLevel', context: context);

  @override
  int get blockLevel {
    _$blockLevelAtom.reportRead();
    return super.blockLevel;
  }

  bool _blockLevelIsInitialized = false;

  @override
  set blockLevel(int value) {
    _$blockLevelAtom.reportWrite(
        value, _blockLevelIsInitialized ? super.blockLevel : null, () {
      super.blockLevel = value;
      _blockLevelIsInitialized = true;
    });
  }

  late final _$selectedArtistsAtom =
      Atom(name: '_SmartListStore.selectedArtists', context: context);

  @override
  ObservableSet<Artist> get selectedArtists {
    _$selectedArtistsAtom.reportRead();
    return super.selectedArtists;
  }

  bool _selectedArtistsIsInitialized = false;

  @override
  set selectedArtists(ObservableSet<Artist> value) {
    _$selectedArtistsAtom.reportWrite(
        value, _selectedArtistsIsInitialized ? super.selectedArtists : null,
        () {
      super.selectedArtists = value;
      _selectedArtistsIsInitialized = true;
    });
  }

  late final _$excludeArtistsAtom =
      Atom(name: '_SmartListStore.excludeArtists', context: context);

  @override
  bool get excludeArtists {
    _$excludeArtistsAtom.reportRead();
    return super.excludeArtists;
  }

  bool _excludeArtistsIsInitialized = false;

  @override
  set excludeArtists(bool value) {
    _$excludeArtistsAtom.reportWrite(
        value, _excludeArtistsIsInitialized ? super.excludeArtists : null, () {
      super.excludeArtists = value;
      _excludeArtistsIsInitialized = true;
    });
  }

  late final _$orderStateAtom =
      Atom(name: '_SmartListStore.orderState', context: context);

  @override
  ObservableList<OrderEntry> get orderState {
    _$orderStateAtom.reportRead();
    return super.orderState;
  }

  bool _orderStateIsInitialized = false;

  @override
  set orderState(ObservableList<OrderEntry> value) {
    _$orderStateAtom.reportWrite(
        value, _orderStateIsInitialized ? super.orderState : null, () {
      super.orderState = value;
      _orderStateIsInitialized = true;
    });
  }

  late final _$shuffleModeAtom =
      Atom(name: '_SmartListStore.shuffleMode', context: context);

  @override
  ShuffleMode? get shuffleMode {
    _$shuffleModeAtom.reportRead();
    return super.shuffleMode;
  }

  bool _shuffleModeIsInitialized = false;

  @override
  set shuffleMode(ShuffleMode? value) {
    _$shuffleModeAtom.reportWrite(
        value, _shuffleModeIsInitialized ? super.shuffleMode : null, () {
      super.shuffleMode = value;
      _shuffleModeIsInitialized = true;
    });
  }

  late final _$_SmartListStoreActionController =
      ActionController(name: '_SmartListStore', context: context);

  @override
  void setShuffleModeIndex(int index) {
    final _$actionInfo = _$_SmartListStoreActionController.startAction(
        name: '_SmartListStore.setShuffleModeIndex');
    try {
      return super.setShuffleModeIndex(index);
    } finally {
      _$_SmartListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOrderEnabled(int index, bool enabled) {
    final _$actionInfo = _$_SmartListStoreActionController.startAction(
        name: '_SmartListStore.setOrderEnabled');
    try {
      return super.setOrderEnabled(index, enabled);
    } finally {
      _$_SmartListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleOrderDirection(int index) {
    final _$actionInfo = _$_SmartListStoreActionController.startAction(
        name: '_SmartListStore.toggleOrderDirection');
    try {
      return super.toggleOrderDirection(index);
    } finally {
      _$_SmartListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reorderOrderState(int oldIndex, int newIndex) {
    final _$actionInfo = _$_SmartListStoreActionController.startAction(
        name: '_SmartListStore.reorderOrderState');
    try {
      return super.reorderOrderState(oldIndex, newIndex);
    } finally {
      _$_SmartListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addArtist(Artist artist) {
    final _$actionInfo = _$_SmartListStoreActionController.startAction(
        name: '_SmartListStore.addArtist');
    try {
      return super.addArtist(artist);
    } finally {
      _$_SmartListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeArtist(Artist artist) {
    final _$actionInfo = _$_SmartListStoreActionController.startAction(
        name: '_SmartListStore.removeArtist');
    try {
      return super.removeArtist(artist);
    } finally {
      _$_SmartListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
minLikeCount: ${minLikeCount},
maxLikeCount: ${maxLikeCount},
minPlayCountEnabled: ${minPlayCountEnabled},
minPlayCount: ${minPlayCount},
maxPlayCountEnabled: ${maxPlayCountEnabled},
maxPlayCount: ${maxPlayCount},
minYearEnabled: ${minYearEnabled},
minYear: ${minYear},
maxYearEnabled: ${maxYearEnabled},
maxYear: ${maxYear},
limitEnabled: ${limitEnabled},
limit: ${limit},
blockLevel: ${blockLevel},
selectedArtists: ${selectedArtists},
excludeArtists: ${excludeArtists},
orderState: ${orderState},
shuffleMode: ${shuffleMode},
shuffleModeIndex: ${shuffleModeIndex}
    ''';
  }
}

mixin _$FormErrorState on _FormErrorState, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_FormErrorState.hasErrors'))
          .value;

  late final _$nameAtom = Atom(name: '_FormErrorState.name', context: context);

  @override
  bool get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(bool value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$minPlayCountAtom =
      Atom(name: '_FormErrorState.minPlayCount', context: context);

  @override
  String? get minPlayCount {
    _$minPlayCountAtom.reportRead();
    return super.minPlayCount;
  }

  @override
  set minPlayCount(String? value) {
    _$minPlayCountAtom.reportWrite(value, super.minPlayCount, () {
      super.minPlayCount = value;
    });
  }

  late final _$maxPlayCountAtom =
      Atom(name: '_FormErrorState.maxPlayCount', context: context);

  @override
  String? get maxPlayCount {
    _$maxPlayCountAtom.reportRead();
    return super.maxPlayCount;
  }

  @override
  set maxPlayCount(String? value) {
    _$maxPlayCountAtom.reportWrite(value, super.maxPlayCount, () {
      super.maxPlayCount = value;
    });
  }

  late final _$minYearAtom =
      Atom(name: '_FormErrorState.minYear', context: context);

  @override
  String? get minYear {
    _$minYearAtom.reportRead();
    return super.minYear;
  }

  @override
  set minYear(String? value) {
    _$minYearAtom.reportWrite(value, super.minYear, () {
      super.minYear = value;
    });
  }

  late final _$maxYearAtom =
      Atom(name: '_FormErrorState.maxYear', context: context);

  @override
  String? get maxYear {
    _$maxYearAtom.reportRead();
    return super.maxYear;
  }

  @override
  set maxYear(String? value) {
    _$maxYearAtom.reportWrite(value, super.maxYear, () {
      super.maxYear = value;
    });
  }

  late final _$limitAtom =
      Atom(name: '_FormErrorState.limit', context: context);

  @override
  String? get limit {
    _$limitAtom.reportRead();
    return super.limit;
  }

  @override
  set limit(String? value) {
    _$limitAtom.reportWrite(value, super.limit, () {
      super.limit = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
minPlayCount: ${minPlayCount},
maxPlayCount: ${maxPlayCount},
minYear: ${minYear},
maxYear: ${maxYear},
limit: ${limit},
hasErrors: ${hasErrors}
    ''';
  }
}
