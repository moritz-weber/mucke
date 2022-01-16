import 'package:mobx/mobx.dart';

import '../../domain/entities/smart_list.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/repositories/settings_repository.dart';

part 'settings_store.g.dart';

class SettingsStore extends _SettingsStore with _$SettingsStore {
  SettingsStore({
    required SettingsRepository settingsRepository,
    required MusicDataRepository musicDataRepository,
  }) : super(settingsRepository, musicDataRepository);
}

abstract class _SettingsStore with Store {
  _SettingsStore(
    this._settingsRepository,
    this._musicDataRepository,
  );

  final SettingsRepository _settingsRepository;
  final MusicDataRepository _musicDataRepository;

  @observable
  late ObservableStream<List<SmartList>> smartListsStream =
      _musicDataRepository.smartListsStream.asObservable(initialValue: []);

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

  Future<void> removeSmartList(SmartList smartList) async {
    await _musicDataRepository.removeSmartList(smartList);
  }

  Future<void> setManageExternalStorageGranted(bool granted) async {
    await _settingsRepository.setManageExternalStorageGranted(granted);
  }

  void dispose() {}
}
