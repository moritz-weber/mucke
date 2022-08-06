// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NavigationStore on _NavigationStore, Store {
  Computed<int>? _$navIndexComputed;

  @override
  int get navIndex =>
      (_$navIndexComputed ??= Computed<int>(() => super.navIndex,
              name: '_NavigationStore.navIndex'))
          .value;

  late final _$navIndexHistoryAtom =
      Atom(name: '_NavigationStore.navIndexHistory', context: context);

  @override
  ObservableList<int> get navIndexHistory {
    _$navIndexHistoryAtom.reportRead();
    return super.navIndexHistory;
  }

  @override
  set navIndexHistory(ObservableList<int> value) {
    _$navIndexHistoryAtom.reportWrite(value, super.navIndexHistory, () {
      super.navIndexHistory = value;
    });
  }

  late final _$_NavigationStoreActionController =
      ActionController(name: '_NavigationStore', context: context);

  @override
  bool setNavIndex(int i, {bool updateTypeHistory = true}) {
    final _$actionInfo = _$_NavigationStoreActionController.startAction(
        name: '_NavigationStore.setNavIndex');
    try {
      return super.setNavIndex(i, updateTypeHistory: updateTypeHistory);
    } finally {
      _$_NavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  int popNavIndex() {
    final _$actionInfo = _$_NavigationStoreActionController.startAction(
        name: '_NavigationStore.popNavIndex');
    try {
      return super.popNavIndex();
    } finally {
      _$_NavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
navIndexHistory: ${navIndexHistory},
navIndex: ${navIndex}
    ''';
  }
}
