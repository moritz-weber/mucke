import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_data_source.dart';
import '../models/smart_list_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._settingsDataSource);

  final SettingsDataSource _settingsDataSource;

  @override
  Stream<List<String>> get libraryFoldersStream => _settingsDataSource.libraryFoldersStream;

  @override
  Future<void> addLibraryFolder(String? path) async {
    if (path == null) return;
    await _settingsDataSource.addLibraryFolder(path);
  }

  @override
  Future<void> removeLibraryFolder(String? path) async {
    if (path == null) return;
    await _settingsDataSource.removeLibraryFolder(path);
  }

  @override
  Future<void> insertSmartList({
    required String name,
    required Filter filter,
    required OrderBy orderBy,
    ShuffleMode? shuffleMode,
  }) {
    return _settingsDataSource.insertSmartList(name, filter, orderBy, shuffleMode);
  }

  @override
  Future<void> removeSmartList(SmartList smartList) =>
      _settingsDataSource.removeSmartList(smartList as SmartListModel);

  @override
  Stream<List<SmartList>> get smartListsStream => _settingsDataSource.smartListsStream;

  @override
  Stream<SmartList> getSmartListStream(int smartListId) =>
      _settingsDataSource.getSmartListStream(smartListId);

  @override
  Future<void> updateSmartList(SmartList smartList) {
    return _settingsDataSource.updateSmartList(
      SmartListModel(
        id: smartList.id,
        name: smartList.name,
        filter: smartList.filter,
        orderBy: smartList.orderBy,
        shuffleMode: smartList.shuffleMode,
      ),
    );
  }
}
