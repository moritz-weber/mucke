// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MusicDataStore on _MusicDataStore, Store {
  late final _$songStreamAtom =
      Atom(name: '_MusicDataStore.songStream', context: context);

  @override
  ObservableStream<List<Song>> get songStream {
    _$songStreamAtom.reportRead();
    return super.songStream;
  }

  @override
  set songStream(ObservableStream<List<Song>> value) {
    _$songStreamAtom.reportWrite(value, super.songStream, () {
      super.songStream = value;
    });
  }

  late final _$albumStreamAtom =
      Atom(name: '_MusicDataStore.albumStream', context: context);

  @override
  ObservableStream<List<Album>> get albumStream {
    _$albumStreamAtom.reportRead();
    return super.albumStream;
  }

  @override
  set albumStream(ObservableStream<List<Album>> value) {
    _$albumStreamAtom.reportWrite(value, super.albumStream, () {
      super.albumStream = value;
    });
  }

  late final _$artistStreamAtom =
      Atom(name: '_MusicDataStore.artistStream', context: context);

  @override
  ObservableStream<List<Artist>> get artistStream {
    _$artistStreamAtom.reportRead();
    return super.artistStream;
  }

  @override
  set artistStream(ObservableStream<List<Artist>> value) {
    _$artistStreamAtom.reportWrite(value, super.artistStream, () {
      super.artistStream = value;
    });
  }

  late final _$playlistsStreamAtom =
      Atom(name: '_MusicDataStore.playlistsStream', context: context);

  @override
  ObservableStream<List<Playlist>> get playlistsStream {
    _$playlistsStreamAtom.reportRead();
    return super.playlistsStream;
  }

  @override
  set playlistsStream(ObservableStream<List<Playlist>> value) {
    _$playlistsStreamAtom.reportWrite(value, super.playlistsStream, () {
      super.playlistsStream = value;
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

  late final _$albumOfDayAtom =
      Atom(name: '_MusicDataStore.albumOfDay', context: context);

  @override
  ObservableFuture<Album?> get albumOfDay {
    _$albumOfDayAtom.reportRead();
    return super.albumOfDay;
  }

  @override
  set albumOfDay(ObservableFuture<Album?> value) {
    _$albumOfDayAtom.reportWrite(value, super.albumOfDay, () {
      super.albumOfDay = value;
    });
  }

  late final _$updateDatabaseAsyncAction =
      AsyncAction('_MusicDataStore.updateDatabase', context: context);

  @override
  Future<void> updateDatabase() {
    return _$updateDatabaseAsyncAction.run(() => super.updateDatabase());
  }

  @override
  String toString() {
    return '''
songStream: ${songStream},
albumStream: ${albumStream},
artistStream: ${artistStream},
playlistsStream: ${playlistsStream},
isUpdatingDatabase: ${isUpdatingDatabase},
albumOfDay: ${albumOfDay}
    ''';
  }
}
