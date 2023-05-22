import '../entities/app_data.dart';

abstract class ImportExportRepository {

  /// Read data from a file and return a Map if successful.
  Future<Map<String, dynamic>?> readDataFile(String inputPath);
  /// Import data from a Map and return true if successful.
  Future<bool> importData(AppData data, DataSelection selection);
  /// Write data to a file and return the path of the file if successful.
  Future<String?> exportData(String outputPath, DataSelection selection);
  /// Create an AppData object from a Map.
  AppData getAppData(Map<String, dynamic> data);
}