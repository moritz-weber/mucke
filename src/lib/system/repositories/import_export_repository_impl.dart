import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../domain/entities/app_data.dart';
import '../../domain/repositories/import_export_repository.dart';
import '../datasources/drift_database.dart';
import '../datasources/settings_data_source.dart';
import '../models/app_data_model.dart';

class ImportExportRepositoryImpl implements ImportExportRepository {
  ImportExportRepositoryImpl(this._settingsDataSource);

  final SettingsDataSource _settingsDataSource;

  @override
  Future<Map<String, dynamic>?> readDataFile(String inputPath) async {
    final contents = await File(inputPath).readAsString();
    return json.decode(contents) as Map<String, dynamic>;
  }

  @override
  Future<bool> importData(AppData data, DataSelection selection) async {
    if (selection.generalSettings && data.generalSettings != null) {
      final settings = data.generalSettings!;
      await _loadSettings(settings.map((key, value) => MapEntry(key, value as String)));
    }
    return true;
  }

  @override
  Future<String?> exportData(String outputPath, DataSelection selection) async {
    final packageInfo = await PackageInfo.fromPlatform();

    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;

    final db = GetIt.I<MainDatabase>();

    // TODO: maybe move this to AppDataModel
    final data = {
      APP_VERSION: version,
      BUILD_NUMBER: buildNumber,
      DB_VERSION: db.schemaVersion,
    };

    if (selection.generalSettings) {
      final settings = await _settingsToMap();
      data[SETTINGS] = settings;
    }

    final dataJSON = json.encode(data);
    print(dataJSON);

    final file = File('$outputPath/${_fileName()}');
    await file.writeAsString(dataJSON);
    return file.path;
  }

  @override
  AppData getAppData(Map<String, dynamic> data) {
    return AppDataModel.fromMap(data);
  }

  Future<Map> _settingsToMap() async {
    final settings = await _settingsDataSource.getKeyValueSettings();

    return settings;
  }

  Future<void> _loadSettings(Map<String, String> settings) async {
    await _settingsDataSource.loadKeyValueSettings(settings);
  }
}

String _fileName() {
  final now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd_H-m-s');
  final String formatted = formatter.format(now);

  return 'mucke_$formatted.json';
}
