import 'package:mobx/mobx.dart';

import '../../domain/entities/app_data.dart';
import '../../domain/repositories/import_export_repository.dart';

part 'export_store.g.dart';

class ExportStore extends _ExportStore with _$ExportStore {
  ExportStore({
    required ImportExportRepository importExportRepository,
  }) : super(importExportRepository);
}

abstract class _ExportStore with Store {
  _ExportStore(
    this._importExportRepository,
  );

  final ImportExportRepository _importExportRepository;

  @readonly
  DataSelection _selection = DataSelection.all();

  @observable
  bool isExporting = false;

  @action
  void setSongsAlbumsArtists(bool selected) {
    _selection.songsAlbumsArtists = selected;
    _selection = _selection.copy();
  }

  @action
  void setSmartlists(bool selected) {
    _selection.smartlists = selected;
    _selection = _selection.copy();
  }

  @action
  void setPlaylists(bool selected) {
    _selection.playlists = selected;
    _selection = _selection.copy();
  }

  @action
  void setLibraryFolders(bool selected) {
    _selection.libraryFolders = selected;
    _selection = _selection.copy();
  }

  @action
  void setGeneralSettings(bool selected) {
    _selection.generalSettings = selected;
    _selection = _selection.copy();
  }

  Future<String?> exportData(String? path) async {
    if (path != null) {
      isExporting = true;
      final exportPath = await _importExportRepository.exportData(path, _selection);
      isExporting = false;
      return exportPath;
    }
    return null;
  }

  void dispose() {}
}
