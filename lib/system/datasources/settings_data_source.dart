abstract class SettingsDataSource {
  Future<void> addLibraryFolder(String path);
  Future<List<String>> getLibraryFolders();
}