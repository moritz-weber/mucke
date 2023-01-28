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

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$minLikeCountAtom =
      Atom(name: '_SmartListStore.minLikeCount', context: context);

  @override
  int get minLikeCount {
    _$minLikeCountAtom.reportRead();
    return super.minLikeCount;
  }

  @override
  set minLikeCount(int value) {
    _$minLikeCountAtom.reportWrite(value, super.minLikeCount, () {
      super.minLikeCount = value;
    });
  }

  late final _$maxLikeCountAtom =
      Atom(name: '_SmartListStore.maxLikeCount', context: context);

  @override
  int get maxLikeCount {
    _$maxLikeCountAtom.reportRead();
    return super.maxLikeCount;
  }

  @override
  set maxLikeCount(int value) {
    _$maxLikeCountAtom.reportWrite(value, super.maxLikeCount, () {
      super.maxLikeCount = value;
    });
  }

  late final _$minPlayCountEnabledAtom =
      Atom(name: '_SmartListStore.minPlayCountEnabled', context: context);

  @override
  bool get minPlayCountEnabled {
    _$minPlayCountEnabledAtom.reportRead();
    return super.minPlayCountEnabled;
  }

  @override
  set minPlayCountEnabled(bool value) {
    _$minPlayCountEnabledAtom.reportWrite(value, super.minPlayCountEnabled, () {
      super.minPlayCountEnabled = value;
    });
  }

  late final _$minPlayCountAtom =
      Atom(name: '_SmartListStore.minPlayCount', context: context);

  @override
  String get minPlayCount {
    _$minPlayCountAtom.reportRead();
    return super.minPlayCount;
  }

  @override
  set minPlayCount(String value) {
    _$minPlayCountAtom.reportWrite(value, super.minPlayCount, () {
      super.minPlayCount = value;
    });
  }

  late final _$maxPlayCountEnabledAtom =
      Atom(name: '_SmartListStore.maxPlayCountEnabled', context: context);

  @override
  bool get maxPlayCountEnabled {
    _$maxPlayCountEnabledAtom.reportRead();
    return super.maxPlayCountEnabled;
  }

  @override
  set maxPlayCountEnabled(bool value) {
    _$maxPlayCountEnabledAtom.reportWrite(value, super.maxPlayCountEnabled, () {
      super.maxPlayCountEnabled = value;
    });
  }

  late final _$maxPlayCountAtom =
      Atom(name: '_SmartListStore.maxPlayCount', context: context);

  @override
  String get maxPlayCount {
    _$maxPlayCountAtom.reportRead();
    return super.maxPlayCount;
  }

  @override
  set maxPlayCount(String value) {
    _$maxPlayCountAtom.reportWrite(value, super.maxPlayCount, () {
      super.maxPlayCount = value;
    });
  }

  late final _$minYearEnabledAtom =
      Atom(name: '_SmartListStore.minYearEnabled', context: context);

  @override
  bool get minYearEnabled {
    _$minYearEnabledAtom.reportRead();
    return super.minYearEnabled;
  }

  @override
  set minYearEnabled(bool value) {
    _$minYearEnabledAtom.reportWrite(value, super.minYearEnabled, () {
      super.minYearEnabled = value;
    });
  }

  late final _$minYearAtom =
      Atom(name: '_SmartListStore.minYear', context: context);

  @override
  String get minYear {
    _$minYearAtom.reportRead();
    return super.minYear;
  }

  @override
  set minYear(String value) {
    _$minYearAtom.reportWrite(value, super.minYear, () {
      super.minYear = value;
    });
  }

  late final _$maxYearEnabledAtom =
      Atom(name: '_SmartListStore.maxYearEnabled', context: context);

  @override
  bool get maxYearEnabled {
    _$maxYearEnabledAtom.reportRead();
    return super.maxYearEnabled;
  }

  @override
  set maxYearEnabled(bool value) {
    _$maxYearEnabledAtom.reportWrite(value, super.maxYearEnabled, () {
      super.maxYearEnabled = value;
    });
  }

  late final _$maxYearAtom =
      Atom(name: '_SmartListStore.maxYear', context: context);

  @override
  String get maxYear {
    _$maxYearAtom.reportRead();
    return super.maxYear;
  }

  @override
  set maxYear(String value) {
    _$maxYearAtom.reportWrite(value, super.maxYear, () {
      super.maxYear = value;
    });
  }

  late final _$limitEnabledAtom =
      Atom(name: '_SmartListStore.limitEnabled', context: context);

  @override
  bool get limitEnabled {
    _$limitEnabledAtom.reportRead();
    return super.limitEnabled;
  }

  @override
  set limitEnabled(bool value) {
    _$limitEnabledAtom.reportWrite(value, super.limitEnabled, () {
      super.limitEnabled = value;
    });
  }

  late final _$limitAtom =
      Atom(name: '_SmartListStore.limit', context: context);

  @override
  String get limit {
    _$limitAtom.reportRead();
    return super.limit;
  }

  @override
  set limit(String value) {
    _$limitAtom.reportWrite(value, super.limit, () {
      super.limit = value;
    });
  }

  late final _$blockLevelAtom =
      Atom(name: '_SmartListStore.blockLevel', context: context);

  @override
  int get blockLevel {
    _$blockLevelAtom.reportRead();
    return super.blockLevel;
  }

  @override
  set blockLevel(int value) {
    _$blockLevelAtom.reportWrite(value, super.blockLevel, () {
      super.blockLevel = value;
    });
  }

  late final _$selectedArtistsAtom =
      Atom(name: '_SmartListStore.selectedArtists', context: context);

  @override
  ObservableSet<Artist> get selectedArtists {
    _$selectedArtistsAtom.reportRead();
    return super.selectedArtists;
  }

  @override
  set selectedArtists(ObservableSet<Artist> value) {
    _$selectedArtistsAtom.reportWrite(value, super.selectedArtists, () {
      super.selectedArtists = value;
    });
  }

  late final _$excludeArtistsAtom =
      Atom(name: '_SmartListStore.excludeArtists', context: context);

  @override
  bool get excludeArtists {
    _$excludeArtistsAtom.reportRead();
    return super.excludeArtists;
  }

  @override
  set excludeArtists(bool value) {
    _$excludeArtistsAtom.reportWrite(value, super.excludeArtists, () {
      super.excludeArtists = value;
    });
  }

  late final _$orderStateAtom =
      Atom(name: '_SmartListStore.orderState', context: context);

  @override
  ObservableList<OrderEntry> get orderState {
    _$orderStateAtom.reportRead();
    return super.orderState;
  }

  @override
  set orderState(ObservableList<OrderEntry> value) {
    _$orderStateAtom.reportWrite(value, super.orderState, () {
      super.orderState = value;
    });
  }

  late final _$shuffleModeAtom =
      Atom(name: '_SmartListStore.shuffleMode', context: context);

  @override
  ShuffleMode? get shuffleMode {
    _$shuffleModeAtom.reportRead();
    return super.shuffleMode;
  }

  @override
  set shuffleMode(ShuffleMode? value) {
    _$shuffleModeAtom.reportWrite(value, super.shuffleMode, () {
      super.shuffleMode = value;
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
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
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
