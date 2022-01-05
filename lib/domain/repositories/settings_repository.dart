abstract class SettingsInfoRepository {
  Stream<List<String>> get libraryFoldersStream;
}

abstract class SettingsRepository extends SettingsInfoRepository {
  Future<void> addLibraryFolder(String? path);
  Future<void> removeLibraryFolder(String? path);
}
