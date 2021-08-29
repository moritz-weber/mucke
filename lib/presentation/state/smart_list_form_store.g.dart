// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_list_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SmartListFormStore on _SmartListStore, Store {
  final _$nameAtom = Atom(name: '_SmartListStore.name');

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

  final _$minLikeCountAtom = Atom(name: '_SmartListStore.minLikeCount');

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

  final _$maxLikeCountAtom = Atom(name: '_SmartListStore.maxLikeCount');

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

  final _$minPlayCountEnabledAtom =
      Atom(name: '_SmartListStore.minPlayCountEnabled');

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

  final _$minPlayCountAtom = Atom(name: '_SmartListStore.minPlayCount');

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

  final _$maxPlayCountEnabledAtom =
      Atom(name: '_SmartListStore.maxPlayCountEnabled');

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

  final _$maxPlayCountAtom = Atom(name: '_SmartListStore.maxPlayCount');

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

  final _$limitEnabledAtom = Atom(name: '_SmartListStore.limitEnabled');

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

  final _$limitAtom = Atom(name: '_SmartListStore.limit');

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

  final _$orderStateAtom = Atom(name: '_SmartListStore.orderState');

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

  final _$_SmartListStoreActionController =
      ActionController(name: '_SmartListStore');

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
  String toString() {
    return '''
name: ${name},
minLikeCount: ${minLikeCount},
maxLikeCount: ${maxLikeCount},
minPlayCountEnabled: ${minPlayCountEnabled},
minPlayCount: ${minPlayCount},
maxPlayCountEnabled: ${maxPlayCountEnabled},
maxPlayCount: ${maxPlayCount},
limitEnabled: ${limitEnabled},
limit: ${limit},
orderState: ${orderState}
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

  final _$nameAtom = Atom(name: '_FormErrorState.name');

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

  final _$minPlayCountAtom = Atom(name: '_FormErrorState.minPlayCount');

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

  final _$maxPlayCountAtom = Atom(name: '_FormErrorState.maxPlayCount');

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

  final _$limitAtom = Atom(name: '_FormErrorState.limit');

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
limit: ${limit},
hasErrors: ${hasErrors}
    ''';
  }
}
