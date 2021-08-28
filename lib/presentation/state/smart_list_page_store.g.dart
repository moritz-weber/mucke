// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_list_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SmartListPageStore on _SmartListPageStore, Store {
  final _$smartListSongStreamAtom =
      Atom(name: '_SmartListPageStore.smartListSongStream');

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

  @override
  String toString() {
    return '''
smartListSongStream: ${smartListSongStream}
    ''';
  }
}
