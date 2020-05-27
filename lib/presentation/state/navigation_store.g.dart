// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NavigationStore on _NavigationStore, Store {
  final _$navIndexAtom = Atom(name: '_NavigationStore.navIndex');

  @override
  int get navIndex {
    _$navIndexAtom.context.enforceReadPolicy(_$navIndexAtom);
    _$navIndexAtom.reportObserved();
    return super.navIndex;
  }

  @override
  set navIndex(int value) {
    _$navIndexAtom.context.conditionallyRunInAction(() {
      super.navIndex = value;
      _$navIndexAtom.reportChanged();
    }, _$navIndexAtom, name: '${_$navIndexAtom.name}_set');
  }

  final _$_NavigationStoreActionController =
      ActionController(name: '_NavigationStore');

  @override
  void init() {
    final _$actionInfo = _$_NavigationStoreActionController.startAction();
    try {
      return super.init();
    } finally {
      _$_NavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNavIndex(int i) {
    final _$actionInfo = _$_NavigationStoreActionController.startAction();
    try {
      return super.setNavIndex(i);
    } finally {
      _$_NavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'navIndex: ${navIndex.toString()}';
    return '{$string}';
  }
}
