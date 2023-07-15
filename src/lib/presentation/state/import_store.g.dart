// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImportStore on _ImportStore, Store {
  late final _$appDataAtom =
      Atom(name: '_ImportStore.appData', context: context);

  @override
  AppData? get appData {
    _$appDataAtom.reportRead();
    return super.appData;
  }

  @override
  set appData(AppData? value) {
    _$appDataAtom.reportWrite(value, super.appData, () {
      super.appData = value;
    });
  }

  late final _$errorAtom = Atom(name: '_ImportStore.error', context: context);

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$scannedAtom =
      Atom(name: '_ImportStore.scanned', context: context);

  @override
  bool get scanned {
    _$scannedAtom.reportRead();
    return super.scanned;
  }

  @override
  set scanned(bool value) {
    _$scannedAtom.reportWrite(value, super.scanned, () {
      super.scanned = value;
    });
  }

  late final _$addedLibraryFoldersAtom =
      Atom(name: '_ImportStore.addedLibraryFolders', context: context);

  @override
  ObservableList<String> get addedLibraryFolders {
    _$addedLibraryFoldersAtom.reportRead();
    return super.addedLibraryFolders;
  }

  @override
  set addedLibraryFolders(ObservableList<String> value) {
    _$addedLibraryFoldersAtom.reportWrite(value, super.addedLibraryFolders, () {
      super.addedLibraryFolders = value;
    });
  }

  late final _$importingAtom =
      Atom(name: '_ImportStore.importing', context: context);

  @override
  bool get importing {
    _$importingAtom.reportRead();
    return super.importing;
  }

  @override
  set importing(bool value) {
    _$importingAtom.reportWrite(value, super.importing, () {
      super.importing = value;
    });
  }

  late final _$importedMetadataAtom =
      Atom(name: '_ImportStore.importedMetadata', context: context);

  @override
  bool get importedMetadata {
    _$importedMetadataAtom.reportRead();
    return super.importedMetadata;
  }

  @override
  set importedMetadata(bool value) {
    _$importedMetadataAtom.reportWrite(value, super.importedMetadata, () {
      super.importedMetadata = value;
    });
  }

  late final _$importedPlaylistsAtom =
      Atom(name: '_ImportStore.importedPlaylists', context: context);

  @override
  ObservableList<bool> get importedPlaylists {
    _$importedPlaylistsAtom.reportRead();
    return super.importedPlaylists;
  }

  @override
  set importedPlaylists(ObservableList<bool> value) {
    _$importedPlaylistsAtom.reportWrite(value, super.importedPlaylists, () {
      super.importedPlaylists = value;
    });
  }

  late final _$importedSmartlistsAtom =
      Atom(name: '_ImportStore.importedSmartlists', context: context);

  @override
  ObservableList<bool> get importedSmartlists {
    _$importedSmartlistsAtom.reportRead();
    return super.importedSmartlists;
  }

  @override
  set importedSmartlists(ObservableList<bool> value) {
    _$importedSmartlistsAtom.reportWrite(value, super.importedSmartlists, () {
      super.importedSmartlists = value;
    });
  }

  late final _$createdFavoritesAtom =
      Atom(name: '_ImportStore.createdFavorites', context: context);

  @override
  bool get createdFavorites {
    _$createdFavoritesAtom.reportRead();
    return super.createdFavorites;
  }

  @override
  set createdFavorites(bool value) {
    _$createdFavoritesAtom.reportWrite(value, super.createdFavorites, () {
      super.createdFavorites = value;
    });
  }

  late final _$createdNewlyAddedAtom =
      Atom(name: '_ImportStore.createdNewlyAdded', context: context);

  @override
  bool get createdNewlyAdded {
    _$createdNewlyAddedAtom.reportRead();
    return super.createdNewlyAdded;
  }

  @override
  set createdNewlyAdded(bool value) {
    _$createdNewlyAddedAtom.reportWrite(value, super.createdNewlyAdded, () {
      super.createdNewlyAdded = value;
    });
  }

  late final _$readDataFileAsyncAction =
      AsyncAction('_ImportStore.readDataFile', context: context);

  @override
  Future<void> readDataFile(String path) {
    return _$readDataFileAsyncAction.run(() => super.readDataFile(path));
  }

  late final _$importSongMetadataAsyncAction =
      AsyncAction('_ImportStore.importSongMetadata', context: context);

  @override
  Future<void> importSongMetadata() {
    return _$importSongMetadataAsyncAction
        .run(() => super.importSongMetadata());
  }

  late final _$importPlaylistAsyncAction =
      AsyncAction('_ImportStore.importPlaylist', context: context);

  @override
  Future<void> importPlaylist(int i) {
    return _$importPlaylistAsyncAction.run(() => super.importPlaylist(i));
  }

  late final _$importSmartlistAsyncAction =
      AsyncAction('_ImportStore.importSmartlist', context: context);

  @override
  Future<void> importSmartlist(int i) {
    return _$importSmartlistAsyncAction.run(() => super.importSmartlist(i));
  }

  late final _$createFavoritesAsyncAction =
      AsyncAction('_ImportStore.createFavorites', context: context);

  @override
  Future<void> createFavorites(BuildContext context) {
    return _$createFavoritesAsyncAction
        .run(() => super.createFavorites(context));
  }

  late final _$createNewlyAddedAsyncAction =
      AsyncAction('_ImportStore.createNewlyAdded', context: context);

  @override
  Future<void> createNewlyAdded(BuildContext context) {
    return _$createNewlyAddedAsyncAction
        .run(() => super.createNewlyAdded(context));
  }

  @override
  String toString() {
    return '''
appData: ${appData},
error: ${error},
scanned: ${scanned},
addedLibraryFolders: ${addedLibraryFolders},
importing: ${importing},
importedMetadata: ${importedMetadata},
importedPlaylists: ${importedPlaylists},
importedSmartlists: ${importedSmartlists},
createdFavorites: ${createdFavorites},
createdNewlyAdded: ${createdNewlyAdded}
    ''';
  }
}
