// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchPageStore on _SearchPageStore, Store {
  final _$queryAtom = Atom(name: '_SearchPageStore.query');

  @override
  String get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  final _$searchResultsArtistsAtom =
      Atom(name: '_SearchPageStore.searchResultsArtists');

  @override
  ObservableList<Artist> get searchResultsArtists {
    _$searchResultsArtistsAtom.reportRead();
    return super.searchResultsArtists;
  }

  @override
  set searchResultsArtists(ObservableList<Artist> value) {
    _$searchResultsArtistsAtom.reportWrite(value, super.searchResultsArtists,
        () {
      super.searchResultsArtists = value;
    });
  }

  final _$searchResultsAlbumsAtom =
      Atom(name: '_SearchPageStore.searchResultsAlbums');

  @override
  ObservableList<Album> get searchResultsAlbums {
    _$searchResultsAlbumsAtom.reportRead();
    return super.searchResultsAlbums;
  }

  @override
  set searchResultsAlbums(ObservableList<Album> value) {
    _$searchResultsAlbumsAtom.reportWrite(value, super.searchResultsAlbums, () {
      super.searchResultsAlbums = value;
    });
  }

  final _$searchResultsSongsAtom =
      Atom(name: '_SearchPageStore.searchResultsSongs');

  @override
  ObservableList<Song> get searchResultsSongs {
    _$searchResultsSongsAtom.reportRead();
    return super.searchResultsSongs;
  }

  @override
  set searchResultsSongs(ObservableList<Song> value) {
    _$searchResultsSongsAtom.reportWrite(value, super.searchResultsSongs, () {
      super.searchResultsSongs = value;
    });
  }

  final _$searchResultsSmartListsAtom =
      Atom(name: '_SearchPageStore.searchResultsSmartLists');

  @override
  ObservableList<SmartList> get searchResultsSmartLists {
    _$searchResultsSmartListsAtom.reportRead();
    return super.searchResultsSmartLists;
  }

  @override
  set searchResultsSmartLists(ObservableList<SmartList> value) {
    _$searchResultsSmartListsAtom
        .reportWrite(value, super.searchResultsSmartLists, () {
      super.searchResultsSmartLists = value;
    });
  }

  final _$searchResultsPlaylistsAtom =
      Atom(name: '_SearchPageStore.searchResultsPlaylists');

  @override
  ObservableList<Playlist> get searchResultsPlaylists {
    _$searchResultsPlaylistsAtom.reportRead();
    return super.searchResultsPlaylists;
  }

  @override
  set searchResultsPlaylists(ObservableList<Playlist> value) {
    _$searchResultsPlaylistsAtom
        .reportWrite(value, super.searchResultsPlaylists, () {
      super.searchResultsPlaylists = value;
    });
  }

  final _$searchAsyncAction = AsyncAction('_SearchPageStore.search');

  @override
  Future<void> search(String searchText) {
    return _$searchAsyncAction.run(() => super.search(searchText));
  }

  final _$_SearchPageStoreActionController =
      ActionController(name: '_SearchPageStore');

  @override
  void reset() {
    final _$actionInfo = _$_SearchPageStoreActionController.startAction(
        name: '_SearchPageStore.reset');
    try {
      return super.reset();
    } finally {
      _$_SearchPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
query: ${query},
searchResultsArtists: ${searchResultsArtists},
searchResultsAlbums: ${searchResultsAlbums},
searchResultsSongs: ${searchResultsSongs},
searchResultsSmartLists: ${searchResultsSmartLists},
searchResultsPlaylists: ${searchResultsPlaylists}
    ''';
  }
}
