// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QueuePageStore on _QueuePageStore, Store {
  Computed<bool>? _$isAllSelectedComputed;

  @override
  bool get isAllSelected =>
      (_$isAllSelectedComputed ??= Computed<bool>(() => super.isAllSelected,
              name: '_QueuePageStore.isAllSelected'))
          .value;

  final _$isMultiSelectEnabledAtom =
      Atom(name: '_QueuePageStore.isMultiSelectEnabled');

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

  final _$isSelectedAtom = Atom(name: '_QueuePageStore.isSelected');

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

  final _$_QueuePageStoreActionController =
      ActionController(name: '_QueuePageStore');

  @override
  void reset() {
    final _$actionInfo = _$_QueuePageStoreActionController.startAction(
        name: '_QueuePageStore.reset');
    try {
      return super.reset();
    } finally {
      _$_QueuePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleMultiSelect() {
    final _$actionInfo = _$_QueuePageStoreActionController.startAction(
        name: '_QueuePageStore.toggleMultiSelect');
    try {
      return super.toggleMultiSelect();
    } finally {
      _$_QueuePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelected(bool selected, int index) {
    final _$actionInfo = _$_QueuePageStoreActionController.startAction(
        name: '_QueuePageStore.setSelected');
    try {
      return super.setSelected(selected, index);
    } finally {
      _$_QueuePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectAll() {
    final _$actionInfo = _$_QueuePageStoreActionController.startAction(
        name: '_QueuePageStore.selectAll');
    try {
      return super.selectAll();
    } finally {
      _$_QueuePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deselectAll() {
    final _$actionInfo = _$_QueuePageStoreActionController.startAction(
        name: '_QueuePageStore.deselectAll');
    try {
      return super.deselectAll();
    } finally {
      _$_QueuePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isMultiSelectEnabled: ${isMultiSelectEnabled},
isSelected: ${isSelected},
isAllSelected: ${isAllSelected}
    ''';
  }
}
