// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NavigationStore on _NavigationStore, Store {
  final _$navIndexAtom = Atom(name: '_NavigationStore.navIndex');

  @override
  int get navIndex {
    _$navIndexAtom.reportRead();
    return super.navIndex;
  }

  @override
  set navIndex(int value) {
    _$navIndexAtom.reportWrite(value, super.navIndex, () {
      super.navIndex = value;
    });
  }

  final _$_NavigationStoreActionController =
      ActionController(name: '_NavigationStore');

  @override
  void setNavIndex(int i) {
    final _$actionInfo = _$_NavigationStoreActionController.startAction(
        name: '_NavigationStore.setNavIndex');
    try {
      return super.setNavIndex(i);
    } finally {
      _$_NavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
navIndex: ${navIndex}
    ''';
  }
}
