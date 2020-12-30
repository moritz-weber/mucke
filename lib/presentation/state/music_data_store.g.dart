// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MusicDataStore on _MusicDataStore, Store {
  final _$songStreamAtom = Atom(name: '_MusicDataStore.songStream');

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

  final _$albumStreamAtom = Atom(name: '_MusicDataStore.albumStream');

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

  final _$artistStreamAtom = Atom(name: '_MusicDataStore.artistStream');

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

  final _$albumSongStreamAtom = Atom(name: '_MusicDataStore.albumSongStream');

  @override
  ObservableStream<List<Song>> get albumSongStream {
    _$albumSongStreamAtom.reportRead();
    return super.albumSongStream;
  }

  @override
  set albumSongStream(ObservableStream<List<Song>> value) {
    _$albumSongStreamAtom.reportWrite(value, super.albumSongStream, () {
      super.albumSongStream = value;
    });
  }

  final _$artistAlbumStreamAtom =
      Atom(name: '_MusicDataStore.artistAlbumStream');

  @override
  ObservableStream<List<Album>> get artistAlbumStream {
    _$artistAlbumStreamAtom.reportRead();
    return super.artistAlbumStream;
  }

  @override
  set artistAlbumStream(ObservableStream<List<Album>> value) {
    _$artistAlbumStreamAtom.reportWrite(value, super.artistAlbumStream, () {
      super.artistAlbumStream = value;
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

  final _$updateDatabaseAsyncAction =
      AsyncAction('_MusicDataStore.updateDatabase');

  @override
  Future<void> updateDatabase() {
    return _$updateDatabaseAsyncAction.run(() => super.updateDatabase());
  }

  final _$fetchSongsFromAlbumAsyncAction =
      AsyncAction('_MusicDataStore.fetchSongsFromAlbum');

  @override
  Future<void> fetchSongsFromAlbum(Album album) {
    return _$fetchSongsFromAlbumAsyncAction
        .run(() => super.fetchSongsFromAlbum(album));
  }

  final _$fetchAlbumsFromArtistAsyncAction =
      AsyncAction('_MusicDataStore.fetchAlbumsFromArtist');

  @override
  Future<void> fetchAlbumsFromArtist(Artist artist) {
    return _$fetchAlbumsFromArtistAsyncAction
        .run(() => super.fetchAlbumsFromArtist(artist));
  }

  @override
  String toString() {
    return '''
songStream: ${songStream},
albumStream: ${albumStream},
artistStream: ${artistStream},
albumSongStream: ${albumSongStream},
artistAlbumStream: ${artistAlbumStream},
isUpdatingDatabase: ${isUpdatingDatabase}
    ''';
  }
}
