// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImportStore on _ImportStore, Store {
  late final _$appDataAtom =
      Atom(name: '_ImportStore.appData', context: context);

  @override
  AppData? get appData {
    _$appDataAtom.reportRead();
    return super.appData;
  }

  @override
  set appData(AppData? value) {
    _$appDataAtom.reportWrite(value, super.appData, () {
      super.appData = value;
    });
  }

  late final _$generalSettingsAtom =
      Atom(name: '_ImportStore.generalSettings', context: context);

  @override
  bool get generalSettings {
    _$generalSettingsAtom.reportRead();
    return super.generalSettings;
  }

  @override
  set generalSettings(bool value) {
    _$generalSettingsAtom.reportWrite(value, super.generalSettings, () {
      super.generalSettings = value;
    });
  }

  late final _$_readDataFileAsyncAction =
      AsyncAction('_ImportStore._readDataFile', context: context);

  @override
  Future<void> _readDataFile(String path) {
    return _$_readDataFileAsyncAction.run(() => super._readDataFile(path));
  }

  late final _$_ImportStoreActionController =
      ActionController(name: '_ImportStore', context: context);

  @override
  void setGeneralSettings(bool selected) {
    final _$actionInfo = _$_ImportStoreActionController.startAction(
        name: '_ImportStore.setGeneralSettings');
    try {
      return super.setGeneralSettings(selected);
    } finally {
      _$_ImportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appData: ${appData},
generalSettings: ${generalSettings}
    ''';
  }
}
