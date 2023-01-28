// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  Computed<int>? _$numBlockedFilesComputed;

  @override
  int get numBlockedFiles =>
      (_$numBlockedFilesComputed ??= Computed<int>(() => super.numBlockedFiles,
              name: '_SettingsStore.numBlockedFiles'))
          .value;

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

  late final _$fileExtensionsStreamAtom =
      Atom(name: '_SettingsStore.fileExtensionsStream', context: context);

  @override
  ObservableStream<String> get fileExtensionsStream {
    _$fileExtensionsStreamAtom.reportRead();
    return super.fileExtensionsStream;
  }

  @override
  set fileExtensionsStream(ObservableStream<String> value) {
    _$fileExtensionsStreamAtom.reportWrite(value, super.fileExtensionsStream,
        () {
      super.fileExtensionsStream = value;
    });
  }

  late final _$blockedFilesStreamAtom =
      Atom(name: '_SettingsStore.blockedFilesStream', context: context);

  @override
  ObservableStream<Set<String>> get blockedFilesStream {
    _$blockedFilesStreamAtom.reportRead();
    return super.blockedFilesStream;
  }

  @override
  set blockedFilesStream(ObservableStream<Set<String>> value) {
    _$blockedFilesStreamAtom.reportWrite(value, super.blockedFilesStream, () {
      super.blockedFilesStream = value;
    });
  }

  late final _$playAlbumsInOrderStreamAtom =
      Atom(name: '_SettingsStore.playAlbumsInOrderStream', context: context);

  @override
  ObservableStream<bool> get playAlbumsInOrderStream {
    _$playAlbumsInOrderStreamAtom.reportRead();
    return super.playAlbumsInOrderStream;
  }

  @override
  set playAlbumsInOrderStream(ObservableStream<bool> value) {
    _$playAlbumsInOrderStreamAtom
        .reportWrite(value, super.playAlbumsInOrderStream, () {
      super.playAlbumsInOrderStream = value;
    });
  }

  @override
  String toString() {
    return '''
libraryFoldersStream: ${libraryFoldersStream},
manageExternalStorageGranted: ${manageExternalStorageGranted},
fileExtensionsStream: ${fileExtensionsStream},
blockedFilesStream: ${blockedFilesStream},
playAlbumsInOrderStream: ${playAlbumsInOrderStream},
numBlockedFiles: ${numBlockedFiles}
    ''';
  }
}
