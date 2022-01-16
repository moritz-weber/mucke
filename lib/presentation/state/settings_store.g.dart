// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on _SettingsStore, Store {
  final _$smartListsStreamAtom = Atom(name: '_SettingsStore.smartListsStream');

  @override
  ObservableStream<List<SmartList>> get smartListsStream {
    _$smartListsStreamAtom.reportRead();
    return super.smartListsStream;
  }

  @override
  set smartListsStream(ObservableStream<List<SmartList>> value) {
    _$smartListsStreamAtom.reportWrite(value, super.smartListsStream, () {
      super.smartListsStream = value;
    });
  }

  final _$libraryFoldersStreamAtom =
      Atom(name: '_SettingsStore.libraryFoldersStream');

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

  final _$manageExternalStorageGrantedAtom =
      Atom(name: '_SettingsStore.manageExternalStorageGranted');

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
smartListsStream: ${smartListsStream},
libraryFoldersStream: ${libraryFoldersStream},
manageExternalStorageGranted: ${manageExternalStorageGranted}
    ''';
  }
}
