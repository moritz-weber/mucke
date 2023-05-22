import '../../domain/entities/app_data.dart';

const APP_VERSION = 'APP_VERSION';
const BUILD_NUMBER = 'BUILD_NUMBER';
const DB_VERSION = 'DB_VERSION';
const SETTINGS = 'SETTINGS';

class AppDataModel extends AppData {
  AppDataModel({
    required super.appVersion,
    required super.buildNumber,
    required super.dbVersion,
    super.generalSettings,
  });

  factory AppDataModel.fromMap(Map<String, dynamic> data) {
    return AppDataModel(
      appVersion: data[APP_VERSION].toString(),
      buildNumber: int.parse(data[BUILD_NUMBER].toString()),
      dbVersion: data[DB_VERSION] as int,
      generalSettings: data[SETTINGS] as Map<String, dynamic>?,
    );
  }
}
