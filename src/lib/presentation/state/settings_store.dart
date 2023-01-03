import 'package:mobx/mobx.dart';

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
  late ObservableStream<List<String>> libraryFoldersStream =
      _settingsRepository.libraryFoldersStream.asObservable(initialValue: []);

  @observable
  late ObservableStream<bool> manageExternalStorageGranted =
      _settingsRepository.manageExternalStorageGranted.asObservable(
    initialValue: _settingsRepository.manageExternalStorageGranted.valueOrNull ?? false,
  );

  @observable
  late ObservableStream<String> fileExtensionsStream =
      _settingsRepository.fileExtensionsStream.asObservable(initialValue: '');

  @observable
  late ObservableStream<Set<String>> blockedFilesStream =
      _musicDataRepository.blockedFilesStream.asObservable(initialValue: {});

  @computed
  int get numBlockedFiles => blockedFilesStream.value!.length;

  Future<void> addLibraryFolder(String? path) async {
    await _settingsRepository.addLibraryFolder(path);
  }

  Future<void> removeLibraryFolder(String? path) async {
    await _settingsRepository.removeLibraryFolder(path);
  }

  Future<void> setManageExternalStorageGranted(bool granted) async {
    await _settingsRepository.setManageExternalStorageGranted(granted);
  }

  Future<void> setFileExtensions(String? extensions) async {
    if (extensions != null) await _settingsRepository.setFileExtension(extensions);
  }

  Future<void> addBlockedFiles(List<String> paths) async {
    await _musicDataRepository.addBlockedFiles(paths);
  }

  Future<void> removeBlockedFiles(List<String> paths) async {
    await _musicDataRepository.removeBlockedFiles(paths);
  }

  void dispose() {}
}
