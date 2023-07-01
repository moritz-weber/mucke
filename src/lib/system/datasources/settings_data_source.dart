abstract class SettingsDataSource {
  Stream<List<String>> get libraryFoldersStream;
  Future<void> addLibraryFolder(String path);
  Future<void> removeLibraryFolder(String path);

  Stream<String> get fileExtensionsStream;
  Future<void> setFileExtension(String extensions);

  Stream<bool> get playAlbumsInOrderStream;
  Future<void> setPlayAlbumsInOrder(bool playInOrder);

  Stream<int> get listenedPercentageStream;
  Future<void> setListenedPercentage(int percentage);

  Future<Map<String, String>> getKeyValueSettings();
  Future<void> loadKeyValueSettings(Map<String, String> settings);
  Future<List<String>> getLibraryFolders();
}
