import 'package:mobx/mobx.dart';

import '../../domain/entities/app_data.dart';
import '../../domain/repositories/import_export_repository.dart';

part 'import_store.g.dart';

class ImportStore extends _ImportStore with _$ImportStore {
  ImportStore({
    required ImportExportRepository importExportRepository,
    required String inputPath,
  }) : super(importExportRepository, inputPath);
}

abstract class _ImportStore with Store {
  _ImportStore(
    this._importExportRepository,
    this.inputPath,
  ) {
    _readDataFile(inputPath);
  }

  final ImportExportRepository _importExportRepository;

  String inputPath;
  Map<String, dynamic>? data;

  @observable
  AppData? appData;

  @observable
  bool generalSettings = false;
  @action
  void setGeneralSettings(bool selected) {
    generalSettings = selected && appData?.generalSettings != null;
  }

  @action
  Future<void> _readDataFile(String path) async {
    final _data = await _importExportRepository.readDataFile(inputPath);

    if (_data != null) {
      data = _data;
      appData = _importExportRepository.getAppData(_data);
      setGeneralSettings(true);
    }
  }

  Future<bool?> importData() async {
    if (data != null) {
      final selection = DataSelection(generalSettings: generalSettings);
      return await _importExportRepository.importData(appData!, selection);
    }
    return null;
  }

  void dispose() {}
}
