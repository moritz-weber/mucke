// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_list_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SmartListPageStore on _SmartListPageStore, Store {
  late final _$smartListStreamAtom =
      Atom(name: '_SmartListPageStore.smartListStream', context: context);

  @override
  ObservableStream<SmartList> get smartListStream {
    _$smartListStreamAtom.reportRead();
    return super.smartListStream;
  }

  @override
  set smartListStream(ObservableStream<SmartList> value) {
    _$smartListStreamAtom.reportWrite(value, super.smartListStream, () {
      super.smartListStream = value;
    });
  }

  late final _$smartListSongStreamAtom =
      Atom(name: '_SmartListPageStore.smartListSongStream', context: context);

  @override
  ObservableStream<List<Song>> get smartListSongStream {
    _$smartListSongStreamAtom.reportRead();
    return super.smartListSongStream;
  }

  @override
  set smartListSongStream(ObservableStream<List<Song>> value) {
    _$smartListSongStreamAtom.reportWrite(value, super.smartListSongStream, () {
      super.smartListSongStream = value;
    });
  }

  late final _$_SmartListPageStoreActionController =
      ActionController(name: '_SmartListPageStore', context: context);

  @override
  void _updateSmartList(SmartList? smartList) {
    final _$actionInfo = _$_SmartListPageStoreActionController.startAction(
        name: '_SmartListPageStore._updateSmartList');
    try {
      return super._updateSmartList(smartList);
    } finally {
      _$_SmartListPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
smartListStream: ${smartListStream},
smartListSongStream: ${smartListSongStream}
    ''';
  }
}
