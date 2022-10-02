// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchPageStore on _SearchPageStore, Store {
  late final _$queryAtom =
      Atom(name: '_SearchPageStore.query', context: context);

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

  late final _$searchResultsArtistsAtom =
      Atom(name: '_SearchPageStore.searchResultsArtists', context: context);

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

  late final _$searchResultsAlbumsAtom =
      Atom(name: '_SearchPageStore.searchResultsAlbums', context: context);

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

  late final _$searchResultsSongsAtom =
      Atom(name: '_SearchPageStore.searchResultsSongs', context: context);

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

  late final _$searchResultsSmartListsAtom =
      Atom(name: '_SearchPageStore.searchResultsSmartLists', context: context);

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

  late final _$searchResultsPlaylistsAtom =
      Atom(name: '_SearchPageStore.searchResultsPlaylists', context: context);

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

  late final _$searchAsyncAction =
      AsyncAction('_SearchPageStore.search', context: context);

  @override
  Future<void> search(String searchText) {
    return _$searchAsyncAction.run(() => super.search(searchText));
  }

  late final _$_SearchPageStoreActionController =
      ActionController(name: '_SearchPageStore', context: context);

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
