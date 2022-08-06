// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelectionStore on _SelectionStore, Store {
  Computed<bool>? _$isAllSelectedComputed;

  @override
  bool get isAllSelected =>
      (_$isAllSelectedComputed ??= Computed<bool>(() => super.isAllSelected,
              name: '_SelectionStore.isAllSelected'))
          .value;

  late final _$itemCountAtom =
      Atom(name: '_SelectionStore.itemCount', context: context);

  @override
  int get itemCount {
    _$itemCountAtom.reportRead();
    return super.itemCount;
  }

  @override
  set itemCount(int value) {
    _$itemCountAtom.reportWrite(value, super.itemCount, () {
      super.itemCount = value;
    });
  }

  late final _$isMultiSelectEnabledAtom =
      Atom(name: '_SelectionStore.isMultiSelectEnabled', context: context);

  @override
  bool get isMultiSelectEnabled {
    _$isMultiSelectEnabledAtom.reportRead();
    return super.isMultiSelectEnabled;
  }

  @override
  set isMultiSelectEnabled(bool value) {
    _$isMultiSelectEnabledAtom.reportWrite(value, super.isMultiSelectEnabled,
        () {
      super.isMultiSelectEnabled = value;
    });
  }

  late final _$isSelectedAtom =
      Atom(name: '_SelectionStore.isSelected', context: context);

  @override
  ObservableList<bool> get isSelected {
    _$isSelectedAtom.reportRead();
    return super.isSelected;
  }

  @override
  set isSelected(ObservableList<bool> value) {
    _$isSelectedAtom.reportWrite(value, super.isSelected, () {
      super.isSelected = value;
    });
  }

  late final _$_SelectionStoreActionController =
      ActionController(name: '_SelectionStore', context: context);

  @override
  void setItemCount(int value) {
    final _$actionInfo = _$_SelectionStoreActionController.startAction(
        name: '_SelectionStore.setItemCount');
    try {
      return super.setItemCount(value);
    } finally {
      _$_SelectionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleMultiSelect() {
    final _$actionInfo = _$_SelectionStoreActionController.startAction(
        name: '_SelectionStore.toggleMultiSelect');
    try {
      return super.toggleMultiSelect();
    } finally {
      _$_SelectionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelected(bool selected, int index) {
    final _$actionInfo = _$_SelectionStoreActionController.startAction(
        name: '_SelectionStore.setSelected');
    try {
      return super.setSelected(selected, index);
    } finally {
      _$_SelectionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectAll() {
    final _$actionInfo = _$_SelectionStoreActionController.startAction(
        name: '_SelectionStore.selectAll');
    try {
      return super.selectAll();
    } finally {
      _$_SelectionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deselectAll() {
    final _$actionInfo = _$_SelectionStoreActionController.startAction(
        name: '_SelectionStore.deselectAll');
    try {
      return super.deselectAll();
    } finally {
      _$_SelectionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
itemCount: ${itemCount},
isMultiSelectEnabled: ${isMultiSelectEnabled},
isSelected: ${isSelected},
isAllSelected: ${isAllSelected}
    ''';
  }
}
