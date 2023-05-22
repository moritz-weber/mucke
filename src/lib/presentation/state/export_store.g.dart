// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExportStore on _ExportStore, Store {
  late final _$generalSettingsAtom =
      Atom(name: '_ExportStore.generalSettings', context: context);

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

  late final _$_ExportStoreActionController =
      ActionController(name: '_ExportStore', context: context);

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
generalSettings: ${generalSettings}
    ''';
  }
}
