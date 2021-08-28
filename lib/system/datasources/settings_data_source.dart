import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../models/smart_list_model.dart';

abstract class SettingsDataSource {
  Future<void> addLibraryFolder(String path);
  Future<List<String>> getLibraryFolders();

  Stream<List<SmartListModel>> get smartListsStream;
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
