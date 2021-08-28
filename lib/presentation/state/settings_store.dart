import 'package:mobx/mobx.dart';

import '../../domain/entities/smart_list.dart';
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
  late ObservableStream<List<SmartList>> smartListsStream =
      _settingsRepository.smartListsStream.asObservable(initialValue: []);

  Future<void> addLibraryFolder(String? path) async {
    await _settingsRepository.addLibraryFolder(path);
  }

  Future<void> removeSmartList(SmartList smartList) async {
    await _settingsRepository.removeSmartList(smartList);
  }

  void dispose() {}
}
