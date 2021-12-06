import 'package:rxdart/rxdart.dart';

import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._settingsDataSource) {
    _settingsDataSource.blockSkippedSongsThreshold.listen((event) { 
      _blockSkippedSongsThreshold.add(event);
    });

    _settingsDataSource.isBlockSkippedSongsEnabled.listen((event) { 
      _isBlockSkippedSongsEnabled.add(event);
    });
  }

  final SettingsDataSource _settingsDataSource;

  final BehaviorSubject<int> _blockSkippedSongsThreshold = BehaviorSubject();
  final BehaviorSubject<bool> _isBlockSkippedSongsEnabled = BehaviorSubject();

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
  ValueStream<int> get blockSkippedSongsThreshold => _blockSkippedSongsThreshold.stream;

  @override
  ValueStream<bool> get isBlockSkippedSongsEnabled => _isBlockSkippedSongsEnabled.stream;

  @override
  Future<void> setBlockSkippedSongsThreshold(int threshold) async {
    _settingsDataSource.setBlockSkippedSongsThreshold(threshold);
  }

  @override
  Future<void> setBlockSkippedSongs(bool enabled) async {
    _settingsDataSource.setBlockSkippedSongs(enabled);
  }
}
