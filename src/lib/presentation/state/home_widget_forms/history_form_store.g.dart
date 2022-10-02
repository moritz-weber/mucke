// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryFormStore on _HistoryFormStore, Store {
  late final _$maxEntriesAtom =
      Atom(name: '_HistoryFormStore.maxEntries', context: context);

  @override
  String get maxEntries {
    _$maxEntriesAtom.reportRead();
    return super.maxEntries;
  }

  @override
  set maxEntries(String value) {
    _$maxEntriesAtom.reportWrite(value, super.maxEntries, () {
      super.maxEntries = value;
    });
  }

  @override
  String toString() {
    return '''
maxEntries: ${maxEntries}
    ''';
  }
}
