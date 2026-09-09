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

  bool _libraryFoldersStreamIsInitialized = false;

  @override
  set libraryFoldersStream(ObservableStream<List<String>> value) {
    _$libraryFoldersStreamAtom.reportWrite(value,
        _libraryFoldersStreamIsInitialized ? super.libraryFoldersStream : null,
        () {
      super.libraryFoldersStream = value;
      _libraryFoldersStreamIsInitialized = true;
    });
  }

  late final _$fileExtensionsStreamAtom =
      Atom(name: '_SettingsStore.fileExtensionsStream', context: context);

  @override
  ObservableStream<String> get fileExtensionsStream {
    _$fileExtensionsStreamAtom.reportRead();
    return super.fileExtensionsStream;
  }

  bool _fileExtensionsStreamIsInitialized = false;

  @override
  set fileExtensionsStream(ObservableStream<String> value) {
    _$fileExtensionsStreamAtom.reportWrite(value,
        _fileExtensionsStreamIsInitialized ? super.fileExtensionsStream : null,
        () {
      super.fileExtensionsStream = value;
      _fileExtensionsStreamIsInitialized = true;
    });
  }

  late final _$blockedFilesStreamAtom =
      Atom(name: '_SettingsStore.blockedFilesStream', context: context);

  @override
  ObservableStream<Set<String>> get blockedFilesStream {
    _$blockedFilesStreamAtom.reportRead();
    return super.blockedFilesStream;
  }

  bool _blockedFilesStreamIsInitialized = false;

  @override
  set blockedFilesStream(ObservableStream<Set<String>> value) {
    _$blockedFilesStreamAtom.reportWrite(value,
        _blockedFilesStreamIsInitialized ? super.blockedFilesStream : null, () {
      super.blockedFilesStream = value;
      _blockedFilesStreamIsInitialized = true;
    });
  }

  late final _$listenedPercentageStreamAtom =
      Atom(name: '_SettingsStore.listenedPercentageStream', context: context);

  @override
  ObservableStream<int> get listenedPercentageStream {
    _$listenedPercentageStreamAtom.reportRead();
    return super.listenedPercentageStream;
  }

  bool _listenedPercentageStreamIsInitialized = false;

  @override
  set listenedPercentageStream(ObservableStream<int> value) {
    _$listenedPercentageStreamAtom.reportWrite(
        value,
        _listenedPercentageStreamIsInitialized
            ? super.listenedPercentageStream
            : null, () {
      super.listenedPercentageStream = value;
      _listenedPercentageStreamIsInitialized = true;
    });
  }

  late final _$playAlbumsInOrderStreamAtom =
      Atom(name: '_SettingsStore.playAlbumsInOrderStream', context: context);

  @override
  ObservableStream<bool> get playAlbumsInOrderStream {
    _$playAlbumsInOrderStreamAtom.reportRead();
    return super.playAlbumsInOrderStream;
  }

  bool _playAlbumsInOrderStreamIsInitialized = false;

  @override
  set playAlbumsInOrderStream(ObservableStream<bool> value) {
    _$playAlbumsInOrderStreamAtom.reportWrite(
        value,
        _playAlbumsInOrderStreamIsInitialized
            ? super.playAlbumsInOrderStream
            : null, () {
      super.playAlbumsInOrderStream = value;
      _playAlbumsInOrderStreamIsInitialized = true;
    });
  }

  late final _$manageExternalStorageGrantedAtom = Atom(
      name: '_SettingsStore.manageExternalStorageGranted', context: context);

  @override
  ObservableStream<bool> get manageExternalStorageGranted {
    _$manageExternalStorageGrantedAtom.reportRead();
    return super.manageExternalStorageGranted;
  }

  bool _manageExternalStorageGrantedIsInitialized = false;

  @override
  set manageExternalStorageGranted(ObservableStream<bool> value) {
    _$manageExternalStorageGrantedAtom.reportWrite(
        value,
        _manageExternalStorageGrantedIsInitialized
            ? super.manageExternalStorageGranted
            : null, () {
      super.manageExternalStorageGranted = value;
      _manageExternalStorageGrantedIsInitialized = true;
    });
  }

  @override
  String toString() {
    return '''
libraryFoldersStream: ${libraryFoldersStream},
fileExtensionsStream: ${fileExtensionsStream},
blockedFilesStream: ${blockedFilesStream},
listenedPercentageStream: ${listenedPercentageStream},
playAlbumsInOrderStream: ${playAlbumsInOrderStream},
manageExternalStorageGranted: ${manageExternalStorageGranted},
numBlockedFiles: ${numBlockedFiles}
    ''';
  }
}
