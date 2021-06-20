import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._settingsDataSource);

  final SettingsDataSource _settingsDataSource;

  @override
  Future<void> addLibraryFolder(String? path) async {
    if (path == null) 
      return;
    await _settingsDataSource.addLibraryFolder(path);
  }
}
