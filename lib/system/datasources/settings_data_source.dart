import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../models/smart_list_model.dart';

abstract class SettingsDataSource {
  Stream<List<String>> get libraryFoldersStream;
  Future<void> addLibraryFolder(String path);
  Future<void> removeLibraryFolder(String path);

  Stream<List<SmartListModel>> get smartListsStream;
  Stream<SmartListModel> getSmartListStream(int smartListId);
  Future<void> insertSmartList(
    String name,
    int position,
    Filter filter,
    OrderBy orderBy,
    ShuffleMode? shuffleMode,
  );
  Future<void> updateSmartList(SmartListModel smartListModel);
  Future<void> removeSmartList(SmartListModel smartListModel);
}
