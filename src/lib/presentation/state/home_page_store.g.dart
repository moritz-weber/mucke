// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageStore on _HomePageStore, Store {
  late final _$homeWidgetsStreamAtom =
      Atom(name: '_HomePageStore.homeWidgetsStream', context: context);

  @override
  ObservableStream<List<HomeWidgetRepr>> get homeWidgetsStream {
    _$homeWidgetsStreamAtom.reportRead();
    return super.homeWidgetsStream;
  }

  @override
  set homeWidgetsStream(ObservableStream<List<HomeWidgetRepr>> value) {
    _$homeWidgetsStreamAtom.reportWrite(value, super.homeWidgetsStream, () {
      super.homeWidgetsStream = value;
    });
  }

  @override
  String toString() {
    return '''
homeWidgetsStream: ${homeWidgetsStream}
    ''';
  }
}
