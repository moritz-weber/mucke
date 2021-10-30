import 'package:mobx/mobx.dart';

import '../../domain/repositories/settings_repository.dart';
import '../utils.dart';

part 'settings_page_store.g.dart';

class SettingsPageStore extends _SettingsPageStore with _$SettingsPageStore {
  SettingsPageStore({
    required SettingsRepository settingsRepository,
  }) : super(settingsRepository);
}

abstract class _SettingsPageStore with Store {
  _SettingsPageStore(
    this._settingsRepository,
  );

  final SettingsRepository _settingsRepository;

  final FormErrorState error = FormErrorState();

  @observable
  bool isBlockSkippedSongsEnabled = false;

  @observable
  String blockSkippedSongsThreshold = '-1';

  late List<ReactionDisposer> _disposers;

  Future<void> addLibraryFolder(String? path) async {
    await _settingsRepository.addLibraryFolder(path);
  }

  Future<void> removeLibraryFolder(String? path) async {
    await _settingsRepository.removeLibraryFolder(path);
  }

  @action
  Future<void> init() async {
    isBlockSkippedSongsEnabled = await _settingsRepository.isBlockSkippedSongsEnabled.first;
    blockSkippedSongsThreshold = (await _settingsRepository.blockSkippedSongsThreshold.first).toString();
  }

  void setupValidations() {
    _disposers = [
      reaction((_) => blockSkippedSongsThreshold,
          (String n) => _validateSkipCountThreshold(isBlockSkippedSongsEnabled, n)),
      reaction((_) => isBlockSkippedSongsEnabled, _validateBlockSkipCountEnabled),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    _validateSkipCountThreshold(isBlockSkippedSongsEnabled, blockSkippedSongsThreshold);
  }

  void _validateSkipCountThreshold(bool enabled, String number) {
    error.skipCountThreshold = validateNumber(enabled, number);
    if (!error.hasErrors) {
      final val = int.parse(blockSkippedSongsThreshold);
      _settingsRepository.setBlockSkippedSongsThreshold(val);
    }
  }

  void _validateBlockSkipCountEnabled(bool enabled) {
    _settingsRepository.setBlockSkippedSongs(enabled);
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? skipCountThreshold;

  @computed
  bool get hasErrors => skipCountThreshold != null;
}
