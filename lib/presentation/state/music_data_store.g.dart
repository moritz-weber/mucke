// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MusicDataStore on _MusicDataStore, Store {
  final _$artistsAtom = Atom(name: '_MusicDataStore.artists');

  @override
  ObservableList<Artist> get artists {
    _$artistsAtom.reportRead();
    return super.artists;
  }

  @override
  set artists(ObservableList<Artist> value) {
    _$artistsAtom.reportWrite(value, super.artists, () {
      super.artists = value;
    });
  }

  final _$isFetchingArtistsAtom =
      Atom(name: '_MusicDataStore.isFetchingArtists');

  @override
  bool get isFetchingArtists {
    _$isFetchingArtistsAtom.reportRead();
    return super.isFetchingArtists;
  }

  @override
  set isFetchingArtists(bool value) {
    _$isFetchingArtistsAtom.reportWrite(value, super.isFetchingArtists, () {
      super.isFetchingArtists = value;
    });
  }

  final _$albumsAtom = Atom(name: '_MusicDataStore.albums');

  @override
  ObservableList<Album> get albums {
    _$albumsAtom.reportRead();
    return super.albums;
  }

  @override
  set albums(ObservableList<Album> value) {
    _$albumsAtom.reportWrite(value, super.albums, () {
      super.albums = value;
    });
  }

  final _$isFetchingAlbumsAtom = Atom(name: '_MusicDataStore.isFetchingAlbums');

  @override
  bool get isFetchingAlbums {
    _$isFetchingAlbumsAtom.reportRead();
    return super.isFetchingAlbums;
  }

  @override
  set isFetchingAlbums(bool value) {
    _$isFetchingAlbumsAtom.reportWrite(value, super.isFetchingAlbums, () {
      super.isFetchingAlbums = value;
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

  final _$fetchArtistsAsyncAction = AsyncAction('_MusicDataStore.fetchArtists');

  @override
  Future<void> fetchArtists() {
    return _$fetchArtistsAsyncAction.run(() => super.fetchArtists());
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
artists: ${artists},
isFetchingArtists: ${isFetchingArtists},
albums: ${albums},
isFetchingAlbums: ${isFetchingAlbums},
songs: ${songs},
isFetchingSongs: ${isFetchingSongs},
isUpdatingDatabase: ${isUpdatingDatabase},
albumSongs: ${albumSongs}
    ''';
  }
}
