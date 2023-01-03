abstract class SettingsDataSource {
  Stream<List<String>> get libraryFoldersStream;
  Future<void> addLibraryFolder(String path);
  Future<void> removeLibraryFolder(String path);

  Stream<String> get fileExtensionsStream;
  Future<void> setFileExtension(String extensions);
}
