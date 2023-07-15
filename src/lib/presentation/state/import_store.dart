import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/app_data.dart';
import '../../domain/repositories/import_export_repository.dart';
import '../../domain/repositories/init_repository.dart';

part 'import_store.g.dart';

class ImportStore extends _ImportStore with _$ImportStore {
  ImportStore({
    required ImportExportRepository importExportRepository,
    required InitRepository initRepository,
  }) : super(importExportRepository, initRepository);
}

abstract class _ImportStore with Store {
  _ImportStore(
    this._importExportRepository,
    this._initRepository,
  );

  final ImportExportRepository _importExportRepository;
  final InitRepository _initRepository;

  /// The raw available data.
  Map<String, dynamic>? data;

  /// The available data to import.
  @observable
  AppData? appData;

  @observable
  bool error = false;

  String? get allowedExtensions => appData?.allowedExtensions;
  List<String>? get blockedFiles => appData?.blockedFiles;
  List<String>? get libraryFolders => appData?.libraryFolders;
  Map<String, Map>? get songs => appData?.songs;
  List<String>? get playlists => appData?.playlists?.map((e) => e['name'] as String).toList();
  List<String>? get smartlists => appData?.smartlists?.map((e) => e['name'] as String).toList();

  @observable
  bool scanned = false;

  @observable
  ObservableList<String> addedLibraryFolders = <String>[].asObservable();

  @observable
  bool importing = false;
  @observable
  bool importedMetadata = false;
  @observable
  ObservableList<bool> importedPlaylists = <bool>[].asObservable();
  @observable
  ObservableList<bool> importedSmartlists = <bool>[].asObservable();

  @observable
  bool createdFavorites = false;
  @observable
  bool createdNewlyAdded = false;

  @action
  Future<void> readDataFile(String path) async {
    Map<String, dynamic>? _data;
    try {
      _data = await _importExportRepository.readDataFile(path);
    } on FormatException {
      error = true;
    }

    if (_data != null) {
      data = _data;
      appData = _importExportRepository.getAppData(_data);

      importedPlaylists = (appData?.playlists?.map((e) => false).toList() ?? []).asObservable();
      importedSmartlists = (appData?.smartlists?.map((e) => false).toList() ?? []).asObservable();
    }
  }

  @action
  Future<void> importSongMetadata() async {
    if (songs != null) {
      importing = true;
      await _importExportRepository.importSongMetadata(songs!);
      importing = false;
      importedMetadata = true;
    }
  }

  @action
  Future<void> importPlaylist(int i) async {
    if (appData?.playlists != null) {
      importing = true;
      await _importExportRepository.importPlaylist(appData!.playlists![i], songs!);
      importing = false;
      importedPlaylists[i] = true;
    }
  }

  @action
  Future<void> importSmartlist(int i) async {
    if (appData?.playlists != null) {
      importing = true;
      await _importExportRepository.importSmartlist(appData!.smartlists![i], appData!.artists!);
      importing = false;
      importedSmartlists[i] = true;
    }
  }

  @action
  Future<void> createFavorites(BuildContext context) async {
    _initRepository.createFavoritesSmartlist(context).then((_) => createdFavorites = true);
  }

  @action
  Future<void> createNewlyAdded(BuildContext context) async {
    _initRepository.createNewlyAddedSmartlist(context).then((_) => createdNewlyAdded = true);
  }

  void dispose() {}
}
