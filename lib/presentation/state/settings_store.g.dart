// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  late final _$libraryFoldersStreamAtom =
      Atom(name: '_SettingsStore.libraryFoldersStream', context: context);

  @override
  ObservableStream<List<String>> get libraryFoldersStream {
    _$libraryFoldersStreamAtom.reportRead();
    return super.libraryFoldersStream;
  }

  @override
  set libraryFoldersStream(ObservableStream<List<String>> value) {
    _$libraryFoldersStreamAtom.reportWrite(value, super.libraryFoldersStream,
        () {
      super.libraryFoldersStream = value;
    });
  }

  late final _$manageExternalStorageGrantedAtom = Atom(
      name: '_SettingsStore.manageExternalStorageGranted', context: context);

  @override
  ObservableStream<bool> get manageExternalStorageGranted {
    _$manageExternalStorageGrantedAtom.reportRead();
    return super.manageExternalStorageGranted;
  }

  @override
  set manageExternalStorageGranted(ObservableStream<bool> value) {
    _$manageExternalStorageGrantedAtom
        .reportWrite(value, super.manageExternalStorageGranted, () {
      super.manageExternalStorageGranted = value;
    });
  }

  @override
  String toString() {
    return '''
libraryFoldersStream: ${libraryFoldersStream},
manageExternalStorageGranted: ${manageExternalStorageGranted}
    ''';
  }
}
