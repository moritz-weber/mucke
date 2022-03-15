// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlbumPageStore on _AlbumPageStore, Store {
  Computed<bool>? _$isAllSelectedComputed;

  @override
  bool get isAllSelected =>
      (_$isAllSelectedComputed ??= Computed<bool>(() => super.isAllSelected,
              name: '_AlbumPageStore.isAllSelected'))
          .value;

  final _$albumSongStreamAtom = Atom(name: '_AlbumPageStore.albumSongStream');

  @override
  ObservableStream<List<Song>> get albumSongStream {
    _$albumSongStreamAtom.reportRead();
    return super.albumSongStream;
  }

  @override
  set albumSongStream(ObservableStream<List<Song>> value) {
    _$albumSongStreamAtom.reportWrite(value, super.albumSongStream, () {
      super.albumSongStream = value;
    });
  }

  final _$isMultiSelectEnabledAtom =
      Atom(name: '_AlbumPageStore.isMultiSelectEnabled');

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

  final _$isSelectedAtom = Atom(name: '_AlbumPageStore.isSelected');

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

  final _$_AlbumPageStoreActionController =
      ActionController(name: '_AlbumPageStore');

  @override
  void toggleMultiSelect() {
    final _$actionInfo = _$_AlbumPageStoreActionController.startAction(
        name: '_AlbumPageStore.toggleMultiSelect');
    try {
      return super.toggleMultiSelect();
    } finally {
      _$_AlbumPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelected(bool selected, int index) {
    final _$actionInfo = _$_AlbumPageStoreActionController.startAction(
        name: '_AlbumPageStore.setSelected');
    try {
      return super.setSelected(selected, index);
    } finally {
      _$_AlbumPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectAll() {
    final _$actionInfo = _$_AlbumPageStoreActionController.startAction(
        name: '_AlbumPageStore.selectAll');
    try {
      return super.selectAll();
    } finally {
      _$_AlbumPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deselectAll() {
    final _$actionInfo = _$_AlbumPageStoreActionController.startAction(
        name: '_AlbumPageStore.deselectAll');
    try {
      return super.deselectAll();
    } finally {
      _$_AlbumPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
albumSongStream: ${albumSongStream},
isMultiSelectEnabled: ${isMultiSelectEnabled},
isSelected: ${isSelected},
isAllSelected: ${isAllSelected}
    ''';
  }
}
