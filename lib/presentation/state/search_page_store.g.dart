// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchPageStore on _SearchPageStore, Store {
  final _$searchResultsAtom = Atom(name: '_SearchPageStore.searchResults');

  @override
  ObservableList<dynamic> get searchResults {
    _$searchResultsAtom.reportRead();
    return super.searchResults;
  }

  @override
  set searchResults(ObservableList<dynamic> value) {
    _$searchResultsAtom.reportWrite(value, super.searchResults, () {
      super.searchResults = value;
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
searchResults: ${searchResults}
    ''';
  }
}
