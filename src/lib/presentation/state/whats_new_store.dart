import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../constants.dart';
import '../../domain/entities/home_widgets/home_widget.dart';
import '../../domain/entities/home_widgets/whats_new.dart';
import '../../domain/repositories/home_widget_repository.dart';
import '../../domain/repositories/init_repository.dart';
import '../../domain/repositories/persistent_state_repository.dart';
import '../release_notes/release_notes.dart';

/// Keeps track of which app version the user has already seen and inserts the
/// "What's new" home widget after an upgrade.
class WhatsNewStore {
  WhatsNewStore({
    required HomeWidgetRepository homeWidgetRepository,
    required PersistentStateRepository persistentStateRepository,
    required InitRepository initRepository,
    required PackageInfo packageInfo,
  })  : _homeWidgetRepository = homeWidgetRepository,
        _persistentStateRepository = persistentStateRepository,
        _initRepository = initRepository,
        _packageInfo = packageInfo;

  static final _log = Logger('WhatsNewStore');

  final HomeWidgetRepository _homeWidgetRepository;
  final PersistentStateRepository _persistentStateRepository;
  final InitRepository _initRepository;
  final PackageInfo _packageInfo;

  bool _checked = false;

  /// The version of the running app.
  String get currentVersion => _packageInfo.version;

  /// Whether there are release notes for the running app version.
  bool get hasReleaseNotes => hasReleaseNoteForVersion(currentVersion);

  /// Checks whether the app was upgraded since the last start and, if so,
  /// inserts the "What's new" home widget at the top of the home page.
  ///
  /// Safe to call multiple times; only the first call has an effect.
  Future<void> checkForUpgrade() async {
    if (_checked) return;
    _checked = true;

    try {
      final lastSeenVersion = await _persistentStateRepository.lastSeenVersion;
      if (lastSeenVersion == currentVersion) return;

      // Remember the version before any early return so that the check does
      // not run again on the next start.
      await _persistentStateRepository.setLastSeenVersion(currentVersion);

      // A fresh installation is not an upgrade.
      if (!await _initRepository.isInitialized) return;

      if (!hasReleaseNotes) return;

      await _insertWhatsNewWidget();
    } catch (error, stackTrace) {
      _log.warning('checkForUpgrade failed', error, stackTrace);
    }
  }

  /// Inserts the "What's new" widget at the top of the home page unless it is
  /// already present.
  Future<void> _insertWhatsNewWidget() async {
    final homeWidgets = await _homeWidgetRepository.homeWidgetsStream.first;
    if (homeWidgets
        .any((homeWidget) => homeWidget.type == HomeWidgetType.whats_new)) {
      return;
    }

    final position = homeWidgets.length;
    await _homeWidgetRepository
        .insertHomeWidget(HomeWhatsNew(position: position));
    if (position > 0) {
      await _homeWidgetRepository.moveHomeWidget(position, 0);
    }
    _log.info('inserted what\'s new widget for $currentVersion');
  }

  /// Removes the "What's new" home widget, if present.
  Future<void> dismiss() async {
    try {
      final homeWidgets = await _homeWidgetRepository.homeWidgetsStream.first;
      final whatsNew = homeWidgets
          .where((homeWidget) => homeWidget.type == HomeWidgetType.whats_new)
          .firstOrNull;
      if (whatsNew == null) return;
      await _homeWidgetRepository.removeHomeWidget(whatsNew);
    } catch (error, stackTrace) {
      _log.warning('dismiss failed', error, stackTrace);
    }
  }
}
