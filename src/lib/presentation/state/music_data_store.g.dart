// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MusicDataStore on _MusicDataStore, Store {
  Computed<bool>? _$songListIsEmptyComputed;

  @override
  bool get songListIsEmpty =>
      (_$songListIsEmptyComputed ??= Computed<bool>(() => super.songListIsEmpty,
              name: '_MusicDataStore.songListIsEmpty'))
          .value;

  late final _$songStreamAtom =
      Atom(name: '_MusicDataStore.songStream', context: context);

  @override
  ObservableStream<List<Song>> get songStream {
    _$songStreamAtom.reportRead();
    return super.songStream;
  }

  bool _songStreamIsInitialized = false;

  @override
  set songStream(ObservableStream<List<Song>> value) {
    _$songStreamAtom.reportWrite(
        value, _songStreamIsInitialized ? super.songStream : null, () {
      super.songStream = value;
      _songStreamIsInitialized = true;
    });
  }

  late final _$albumStreamAtom =
      Atom(name: '_MusicDataStore.albumStream', context: context);

  @override
  ObservableStream<List<Album>> get albumStream {
    _$albumStreamAtom.reportRead();
    return super.albumStream;
  }

  bool _albumStreamIsInitialized = false;

  @override
  set albumStream(ObservableStream<List<Album>> value) {
    _$albumStreamAtom.reportWrite(
        value, _albumStreamIsInitialized ? super.albumStream : null, () {
      super.albumStream = value;
      _albumStreamIsInitialized = true;
    });
  }

  late final _$artistStreamAtom =
      Atom(name: '_MusicDataStore.artistStream', context: context);

  @override
  ObservableStream<List<Artist>> get artistStream {
    _$artistStreamAtom.reportRead();
    return super.artistStream;
  }

  bool _artistStreamIsInitialized = false;

  @override
  set artistStream(ObservableStream<List<Artist>> value) {
    _$artistStreamAtom.reportWrite(
        value, _artistStreamIsInitialized ? super.artistStream : null, () {
      super.artistStream = value;
      _artistStreamIsInitialized = true;
    });
  }

  late final _$playlistsStreamAtom =
      Atom(name: '_MusicDataStore.playlistsStream', context: context);

  @override
  ObservableStream<List<Playlist>> get playlistsStream {
    _$playlistsStreamAtom.reportRead();
    return super.playlistsStream;
  }

  bool _playlistsStreamIsInitialized = false;

  @override
  set playlistsStream(ObservableStream<List<Playlist>> value) {
    _$playlistsStreamAtom.reportWrite(
        value, _playlistsStreamIsInitialized ? super.playlistsStream : null,
        () {
      super.playlistsStream = value;
      _playlistsStreamIsInitialized = true;
    });
  }

  late final _$smartListsStreamAtom =
      Atom(name: '_MusicDataStore.smartListsStream', context: context);

  @override
  ObservableStream<List<SmartList>> get smartListsStream {
    _$smartListsStreamAtom.reportRead();
    return super.smartListsStream;
  }

  bool _smartListsStreamIsInitialized = false;

  @override
  set smartListsStream(ObservableStream<List<SmartList>> value) {
    _$smartListsStreamAtom.reportWrite(
        value, _smartListsStreamIsInitialized ? super.smartListsStream : null,
        () {
      super.smartListsStream = value;
      _smartListsStreamIsInitialized = true;
    });
  }

  late final _$isUpdatingDatabaseAtom =
      Atom(name: '_MusicDataStore.isUpdatingDatabase', context: context);

  @override
  bool get isUpdatingDatabase {
    _$isUpdatingDatabaseAtom.reportRead();
    return super.isUpdatingDatabase;
  }

  @override
  set isUpdatingDatabase(bool value) {
    _$isUpdatingDatabaseAtom.reportWrite(value, super.isUpdatingDatabase, () {
      super.isUpdatingDatabase = value;
    });
  }

  late final _$numFileStreamAtom =
      Atom(name: '_MusicDataStore.numFileStream', context: context);

  @override
  ObservableStream<int?> get numFileStream {
    _$numFileStreamAtom.reportRead();
    return super.numFileStream;
  }

  bool _numFileStreamIsInitialized = false;

  @override
  set numFileStream(ObservableStream<int?> value) {
    _$numFileStreamAtom.reportWrite(
        value, _numFileStreamIsInitialized ? super.numFileStream : null, () {
      super.numFileStream = value;
      _numFileStreamIsInitialized = true;
    });
  }

  late final _$progressStreamAtom =
      Atom(name: '_MusicDataStore.progressStream', context: context);

  @override
  ObservableStream<int?> get progressStream {
    _$progressStreamAtom.reportRead();
    return super.progressStream;
  }

  bool _progressStreamIsInitialized = false;

  @override
  set progressStream(ObservableStream<int?> value) {
    _$progressStreamAtom.reportWrite(
        value, _progressStreamIsInitialized ? super.progressStream : null, () {
      super.progressStream = value;
      _progressStreamIsInitialized = true;
    });
  }

  late final _$albumOfDayAtom =
      Atom(name: '_MusicDataStore.albumOfDay', context: context);

  @override
  ObservableStream<Album?> get albumOfDay {
    _$albumOfDayAtom.reportRead();
    return super.albumOfDay;
  }

  bool _albumOfDayIsInitialized = false;

  @override
  set albumOfDay(ObservableStream<Album?> value) {
    _$albumOfDayAtom.reportWrite(
        value, _albumOfDayIsInitialized ? super.albumOfDay : null, () {
      super.albumOfDay = value;
      _albumOfDayIsInitialized = true;
    });
  }

  late final _$artistOfDayAtom =
      Atom(name: '_MusicDataStore.artistOfDay', context: context);

  @override
  ObservableStream<Artist?> get artistOfDay {
    _$artistOfDayAtom.reportRead();
    return super.artistOfDay;
  }

  bool _artistOfDayIsInitialized = false;

  @override
  set artistOfDay(ObservableStream<Artist?> value) {
    _$artistOfDayAtom.reportWrite(
        value, _artistOfDayIsInitialized ? super.artistOfDay : null, () {
      super.artistOfDay = value;
      _artistOfDayIsInitialized = true;
    });
  }

  late final _$updateDatabaseAsyncAction =
      AsyncAction('_MusicDataStore.updateDatabase', context: context);

  @override
  Future<ScanResult> updateDatabase() {
    return _$updateDatabaseAsyncAction.run(() => super.updateDatabase());
  }

  @override
  String toString() {
    return '''
songStream: ${songStream},
albumStream: ${albumStream},
artistStream: ${artistStream},
playlistsStream: ${playlistsStream},
smartListsStream: ${smartListsStream},
isUpdatingDatabase: ${isUpdatingDatabase},
numFileStream: ${numFileStream},
progressStream: ${progressStream},
albumOfDay: ${albumOfDay},
artistOfDay: ${artistOfDay},
songListIsEmpty: ${songListIsEmpty}
    ''';
  }
}
