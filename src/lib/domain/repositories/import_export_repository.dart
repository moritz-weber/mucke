import '../entities/app_data.dart';

abstract class ImportExportRepository {

  /// Read data from a file and return a Map if successful.
  Future<Map<String, dynamic>?> readDataFile(String inputPath);
  /// Write data to a file and return the path of the file if successful.
  Future<String?> exportData(String outputPath, DataSelection selection);
  /// Create an AppData object from a Map.
  AppData getAppData(Map<String, dynamic> data);

  Future<void> importSongMetadata(Map<String, Map> data);
  Future<void> importPlaylist(Map<String, dynamic> playlistData, Map<String, Map> songData);
  Future<void> importSmartlist(Map<String, dynamic> smartlistData, Map<String, Map> artistData);
}