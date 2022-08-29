import 'package:mobx/mobx.dart';

import '../../domain/repositories/settings_repository.dart';

part 'settings_store.g.dart';

class SettingsStore extends _SettingsStore with _$SettingsStore {
  SettingsStore({
    required SettingsRepository settingsRepository,
  }) : super(settingsRepository);
}

abstract class _SettingsStore with Store {
  _SettingsStore(
    this._settingsRepository,
  );

  final SettingsRepository _settingsRepository;

  @observable
  late ObservableStream<List<String>> libraryFoldersStream =
      _settingsRepository.libraryFoldersStream.asObservable(initialValue: []);

  @observable
  late ObservableStream<bool> manageExternalStorageGranted =
      _settingsRepository.manageExternalStorageGranted.asObservable(
    initialValue: _settingsRepository.manageExternalStorageGranted.valueOrNull ?? false,
  );

  Future<void> addLibraryFolder(String? path) async {
    await _settingsRepository.addLibraryFolder(path);
  }

  Future<void> removeLibraryFolder(String? path) async {
    await _settingsRepository.removeLibraryFolder(path);
  }

  Future<void> setManageExternalStorageGranted(bool granted) async {
    await _settingsRepository.setManageExternalStorageGranted(granted);
  }

  void dispose() {}
}
