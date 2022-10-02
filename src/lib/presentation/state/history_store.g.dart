// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryStore on _HistoryStore, Store {
  late final _$historyStreamAtom =
      Atom(name: '_HistoryStore.historyStream', context: context);

  @override
  ObservableStream<List<HistoryEntry>> get historyStream {
    _$historyStreamAtom.reportRead();
    return super.historyStream;
  }

  @override
  set historyStream(ObservableStream<List<HistoryEntry>> value) {
    _$historyStreamAtom.reportWrite(value, super.historyStream, () {
      super.historyStream = value;
    });
  }

  @override
  String toString() {
    return '''
historyStream: ${historyStream}
    ''';
  }
}
