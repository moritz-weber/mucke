import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_data_source.dart';

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
  Stream<int> get blockSkippedSongsThreshold => _settingsDataSource.blockSkippedSongsThreshold;

  @override
  Stream<bool> get isBlockSkippedSongsEnabled => _settingsDataSource.isBlockSkippedSongsEnabled;

  @override
  Future<void> setBlockSkippedSongsThreshold(int threshold) async {
    _settingsDataSource.setBlockSkippedSongsThreshold(threshold);
  }

  @override
  Future<void> setBlockSkippedSongs(bool enabled) async {
    _settingsDataSource.setBlockSkippedSongs(enabled);
  }
}
