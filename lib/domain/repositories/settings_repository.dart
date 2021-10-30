abstract class SettingsRepository {
  Stream<List<String>> get libraryFoldersStream;
  Future<void> addLibraryFolder(String? path);
  Future<void> removeLibraryFolder(String? path);

  Future<void> setBlockSkippedSongs(bool enabled);
  Stream<bool> get isBlockSkippedSongsEnabled;
  Future<void> setBlockSkippedSongsThreshold(int threshold);
  Stream<int> get blockSkippedSongsThreshold;
}
