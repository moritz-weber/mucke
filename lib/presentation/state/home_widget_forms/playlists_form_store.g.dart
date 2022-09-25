// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlists_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlaylistsFormStore on _PlaylistsFormStore, Store {
  late final _$titleAtom =
      Atom(name: '_PlaylistsFormStore.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$maxEntriesAtom =
      Atom(name: '_PlaylistsFormStore.maxEntries', context: context);

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

  late final _$maxEntriesEnabledAtom =
      Atom(name: '_PlaylistsFormStore.maxEntriesEnabled', context: context);

  @override
  bool get maxEntriesEnabled {
    _$maxEntriesEnabledAtom.reportRead();
    return super.maxEntriesEnabled;
  }

  @override
  set maxEntriesEnabled(bool value) {
    _$maxEntriesEnabledAtom.reportWrite(value, super.maxEntriesEnabled, () {
      super.maxEntriesEnabled = value;
    });
  }

  late final _$orderCriterionAtom =
      Atom(name: '_PlaylistsFormStore.orderCriterion', context: context);

  @override
  HomePlaylistsOrder get orderCriterion {
    _$orderCriterionAtom.reportRead();
    return super.orderCriterion;
  }

  @override
  set orderCriterion(HomePlaylistsOrder value) {
    _$orderCriterionAtom.reportWrite(value, super.orderCriterion, () {
      super.orderCriterion = value;
    });
  }

  late final _$orderDirectionAtom =
      Atom(name: '_PlaylistsFormStore.orderDirection', context: context);

  @override
  OrderDirection get orderDirection {
    _$orderDirectionAtom.reportRead();
    return super.orderDirection;
  }

  @override
  set orderDirection(OrderDirection value) {
    _$orderDirectionAtom.reportWrite(value, super.orderDirection, () {
      super.orderDirection = value;
    });
  }

  late final _$filterAtom =
      Atom(name: '_PlaylistsFormStore.filter', context: context);

  @override
  HomePlaylistsFilter get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(HomePlaylistsFilter value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  @override
  String toString() {
    return '''
title: ${title},
maxEntries: ${maxEntries},
maxEntriesEnabled: ${maxEntriesEnabled},
orderCriterion: ${orderCriterion},
orderDirection: ${orderDirection},
filter: ${filter}
    ''';
  }
}
