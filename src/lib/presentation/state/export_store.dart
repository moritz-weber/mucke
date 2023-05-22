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

  @observable
  bool generalSettings = true;
  @action
  void setGeneralSettings(bool selected) {
    generalSettings = selected;
  }

  Future<String?> exportData(String? path) async {
    if (path != null) {
      final selection = DataSelection(generalSettings: generalSettings);
      return await _importExportRepository.exportData(path, selection);
    }
    return null;
  }

  void dispose() {}
}
