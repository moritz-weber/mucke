import '../entities/smart_list.dart';

abstract class SettingsRepository {
  Stream<List<String>> get libraryFoldersStream;
  Future<void> addLibraryFolder(String? path);
  Future<void> removeLibraryFolder(String? path);

  Stream<List<SmartList>> get smartListsStream;
  Stream<SmartList> getSmartListStream(int smartListId);
  Future<void> insertSmartList(SmartList smartList);
  Future<void> updateSmartList(SmartList smartList);
  Future<void> removeSmartList(SmartList smartList);
}
