// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExportStore on _ExportStore, Store {
  late final _$_selectionAtom =
      Atom(name: '_ExportStore._selection', context: context);

  DataSelection get selection {
    _$_selectionAtom.reportRead();
    return super._selection;
  }

  @override
  DataSelection get _selection => selection;

  @override
  set _selection(DataSelection value) {
    _$_selectionAtom.reportWrite(value, super._selection, () {
      super._selection = value;
    });
  }

  late final _$isExportingAtom =
      Atom(name: '_ExportStore.isExporting', context: context);

  @override
  bool get isExporting {
    _$isExportingAtom.reportRead();
    return super.isExporting;
  }

  @override
  set isExporting(bool value) {
    _$isExportingAtom.reportWrite(value, super.isExporting, () {
      super.isExporting = value;
    });
  }

  late final _$_ExportStoreActionController =
      ActionController(name: '_ExportStore', context: context);

  @override
  void setSongsAlbumsArtists(bool selected) {
    final _$actionInfo = _$_ExportStoreActionController.startAction(
        name: '_ExportStore.setSongsAlbumsArtists');
    try {
      return super.setSongsAlbumsArtists(selected);
    } finally {
      _$_ExportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSmartlists(bool selected) {
    final _$actionInfo = _$_ExportStoreActionController.startAction(
        name: '_ExportStore.setSmartlists');
    try {
      return super.setSmartlists(selected);
    } finally {
      _$_ExportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlaylists(bool selected) {
    final _$actionInfo = _$_ExportStoreActionController.startAction(
        name: '_ExportStore.setPlaylists');
    try {
      return super.setPlaylists(selected);
    } finally {
      _$_ExportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLibraryFolders(bool selected) {
    final _$actionInfo = _$_ExportStoreActionController.startAction(
        name: '_ExportStore.setLibraryFolders');
    try {
      return super.setLibraryFolders(selected);
    } finally {
      _$_ExportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGeneralSettings(bool selected) {
    final _$actionInfo = _$_ExportStoreActionController.startAction(
        name: '_ExportStore.setGeneralSettings');
    try {
      return super.setGeneralSettings(selected);
    } finally {
      _$_ExportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isExporting: ${isExporting}
    ''';
  }
}
