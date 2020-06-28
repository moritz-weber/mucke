// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MusicDataStore on _MusicDataStore, Store {
  final _$albumsFutureAtom = Atom(name: '_MusicDataStore.albumsFuture');

  @override
  ObservableFuture<List<Album>> get albumsFuture {
    _$albumsFutureAtom.reportRead();
    return super.albumsFuture;
  }

  @override
  set albumsFuture(ObservableFuture<List<Album>> value) {
    _$albumsFutureAtom.reportWrite(value, super.albumsFuture, () {
      super.albumsFuture = value;
    });
  }

  final _$songsAtom = Atom(name: '_MusicDataStore.songs');

  @override
  ObservableList<Song> get songs {
    _$songsAtom.reportRead();
    return super.songs;
  }

  @override
  set songs(ObservableList<Song> value) {
    _$songsAtom.reportWrite(value, super.songs, () {
      super.songs = value;
    });
  }

  final _$isFetchingSongsAtom = Atom(name: '_MusicDataStore.isFetchingSongs');

  @override
  bool get isFetchingSongs {
    _$isFetchingSongsAtom.reportRead();
    return super.isFetchingSongs;
  }

  @override
  set isFetchingSongs(bool value) {
    _$isFetchingSongsAtom.reportWrite(value, super.isFetchingSongs, () {
      super.isFetchingSongs = value;
    });
  }

  final _$isUpdatingDatabaseAtom =
      Atom(name: '_MusicDataStore.isUpdatingDatabase');

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

  final _$albumSongsAtom = Atom(name: '_MusicDataStore.albumSongs');

  @override
  ObservableList<Song> get albumSongs {
    _$albumSongsAtom.reportRead();
    return super.albumSongs;
  }

  @override
  set albumSongs(ObservableList<Song> value) {
    _$albumSongsAtom.reportWrite(value, super.albumSongs, () {
      super.albumSongs = value;
    });
  }

  final _$updateDatabaseAsyncAction =
      AsyncAction('_MusicDataStore.updateDatabase');

  @override
  Future<void> updateDatabase() {
    return _$updateDatabaseAsyncAction.run(() => super.updateDatabase());
  }

  final _$fetchAlbumsAsyncAction = AsyncAction('_MusicDataStore.fetchAlbums');

  @override
  Future<void> fetchAlbums() {
    return _$fetchAlbumsAsyncAction.run(() => super.fetchAlbums());
  }

  final _$fetchSongsAsyncAction = AsyncAction('_MusicDataStore.fetchSongs');

  @override
  Future<void> fetchSongs() {
    return _$fetchSongsAsyncAction.run(() => super.fetchSongs());
  }

  final _$fetchSongsFromAlbumAsyncAction =
      AsyncAction('_MusicDataStore.fetchSongsFromAlbum');

  @override
  Future<void> fetchSongsFromAlbum(Album album) {
    return _$fetchSongsFromAlbumAsyncAction
        .run(() => super.fetchSongsFromAlbum(album));
  }

  final _$_MusicDataStoreActionController =
      ActionController(name: '_MusicDataStore');

  @override
  void init() {
    final _$actionInfo = _$_MusicDataStoreActionController.startAction(
        name: '_MusicDataStore.init');
    try {
      return super.init();
    } finally {
      _$_MusicDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
albumsFuture: ${albumsFuture},
songs: ${songs},
isFetchingSongs: ${isFetchingSongs},
isUpdatingDatabase: ${isUpdatingDatabase},
albumSongs: ${albumSongs}
    ''';
  }
}
