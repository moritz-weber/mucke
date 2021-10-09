import '../entities/shuffle_mode.dart';
import '../entities/smart_list.dart';

abstract class SettingsRepository {
  Stream<List<String>> get libraryFoldersStream;
  Future<void> addLibraryFolder(String? path);
  Future<void> removeLibraryFolder(String? path);

  // TODO: move to other repository
  Stream<List<SmartList>> get smartListsStream;
  Stream<SmartList> getSmartListStream(int smartListId);
  Future<void> insertSmartList({
    required String name,
    required Filter filter,
    required OrderBy orderBy,
    ShuffleMode? shuffleMode,
  });
  Future<void> updateSmartList(SmartList smartList);
  Future<void> removeSmartList(SmartList smartList);
}
