abstract class SettingsDataSource {
  Stream<List<String>> get libraryFoldersStream;
  Future<void> addLibraryFolder(String path);
  Future<void> removeLibraryFolder(String path);
}
