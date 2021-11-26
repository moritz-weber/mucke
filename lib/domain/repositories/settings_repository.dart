abstract class SettingsInfoRepository {
  Stream<List<String>> get libraryFoldersStream;

  Stream<bool> get isBlockSkippedSongsEnabled;
  Stream<int> get blockSkippedSongsThreshold;
}

abstract class SettingsRepository extends SettingsInfoRepository {
  Future<void> addLibraryFolder(String? path);
  Future<void> removeLibraryFolder(String? path);

  Future<void> setBlockSkippedSongs(bool enabled);
  Future<void> setBlockSkippedSongsThreshold(int threshold);
}
