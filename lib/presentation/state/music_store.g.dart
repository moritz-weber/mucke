// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MusicStore on _MusicStore, Store {
  final _$albumsFutureAtom = Atom(name: '_MusicStore.albumsFuture');

  @override
  ObservableFuture<List<Album>> get albumsFuture {
    _$albumsFutureAtom.context.enforceReadPolicy(_$albumsFutureAtom);
    _$albumsFutureAtom.reportObserved();
    return super.albumsFuture;
  }

  @override
  set albumsFuture(ObservableFuture<List<Album>> value) {
    _$albumsFutureAtom.context.conditionallyRunInAction(() {
      super.albumsFuture = value;
      _$albumsFutureAtom.reportChanged();
    }, _$albumsFutureAtom, name: '${_$albumsFutureAtom.name}_set');
  }

  final _$updateDatabaseAsyncAction = AsyncAction('updateDatabase');

  @override
  Future<void> updateDatabase() {
    return _$updateDatabaseAsyncAction.run(() => super.updateDatabase());
  }

  final _$_MusicStoreActionController = ActionController(name: '_MusicStore');

  @override
  Future<void> fetchAlbums() {
    final _$actionInfo = _$_MusicStoreActionController.startAction();
    try {
      return super.fetchAlbums();
    } finally {
      _$_MusicStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'albumsFuture: ${albumsFuture.toString()}';
    return '{$string}';
  }
}
