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

  final _$isBlockSkippedSongsEnabledAtom =
      Atom(name: '_SettingsStore.isBlockSkippedSongsEnabled');

  @override
  ObservableStream<bool> get isBlockSkippedSongsEnabled {
    _$isBlockSkippedSongsEnabledAtom.reportRead();
    return super.isBlockSkippedSongsEnabled;
  }

  @override
  set isBlockSkippedSongsEnabled(ObservableStream<bool> value) {
    _$isBlockSkippedSongsEnabledAtom
        .reportWrite(value, super.isBlockSkippedSongsEnabled, () {
      super.isBlockSkippedSongsEnabled = value;
    });
  }

  final _$blockSkippedSongsThresholdAtom =
      Atom(name: '_SettingsStore.blockSkippedSongsThreshold');

  @override
  ObservableStream<int> get blockSkippedSongsThreshold {
    _$blockSkippedSongsThresholdAtom.reportRead();
    return super.blockSkippedSongsThreshold;
  }

  @override
  set blockSkippedSongsThreshold(ObservableStream<int> value) {
    _$blockSkippedSongsThresholdAtom
        .reportWrite(value, super.blockSkippedSongsThreshold, () {
      super.blockSkippedSongsThreshold = value;
    });
  }

  @override
  String toString() {
    return '''
smartListsStream: ${smartListsStream},
libraryFoldersStream: ${libraryFoldersStream},
isBlockSkippedSongsEnabled: ${isBlockSkippedSongsEnabled},
blockSkippedSongsThreshold: ${blockSkippedSongsThreshold}
    ''';
  }
}
