import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../domain/entities/home_widgets/home_widget.dart';
import '../../domain/entities/home_widgets/whats_new.dart';
import '../../domain/repositories/home_widget_repository.dart';
import '../../domain/repositories/persistent_state_repository.dart';
import '../release_notes/release_notes.dart';

/// Keeps track of which app version the user has already seen. The "What's
/// new" home widget itself is created by the database migration (upgrades) and
/// by the init flow (fresh installs).
class WhatsNewStore {
  WhatsNewStore({
    required HomeWidgetRepository homeWidgetRepository,
    required PersistentStateRepository persistentStateRepository,
    required PackageInfo packageInfo,
  })  : _homeWidgetRepository = homeWidgetRepository,
        _persistentStateRepository = persistentStateRepository,
        _packageInfo = packageInfo;

  static final _log = Logger('WhatsNewStore');

  final HomeWidgetRepository _homeWidgetRepository;
  final PersistentStateRepository _persistentStateRepository;
  final PackageInfo _packageInfo;

  bool _checked = false;

  /// The version of the running app.
  String get currentVersion => _packageInfo.version;

  /// Whether there are release notes for the running app version.
  bool get hasReleaseNotes => hasReleaseNoteForVersion(currentVersion);

  /// Records the running app version as seen.
  ///
  /// Safe to call multiple times; only the first call has an effect.
  Future<void> checkForUpgrade() async {
    if (_checked) return;
    _checked = true;

    try {
      final lastSeenVersion = await _persistentStateRepository.lastSeenVersion;
      if (lastSeenVersion == currentVersion) return;
      await _persistentStateRepository.setLastSeenVersion(currentVersion);
      _log.info('last seen version set to $currentVersion');
    } catch (error, stackTrace) {
      _log.warning('checkForUpgrade failed', error, stackTrace);
    }
  }

  /// Whether the widget is dismissed automatically when the release notes are
  /// viewed.
  Future<bool> get autoDismiss async {
    final whatsNew = await _getWhatsNew();
    return whatsNew?.autoDismiss ?? true;
  }

  /// Marks the "What's new" home widget as dismissed.
  ///
  /// The widget stays in the list of home widgets so that the user can still
  /// customize its position, but it is no longer displayed on the home page.
  Future<void> dismiss() async {
    try {
      final whatsNew = await _getWhatsNew();
      if (whatsNew == null) return;
      await _homeWidgetRepository.updateHomeWidget(
        HomeWhatsNew(
          position: whatsNew.position,
          dismissed: true,
          autoDismiss: whatsNew.autoDismiss,
        ),
      );
    } catch (error, stackTrace) {
      _log.warning('dismiss failed', error, stackTrace);
    }
  }

  /// Dismisses the widget when the release notes are viewed, if the user did
  /// not disable automatic dismissal.
  Future<void> dismissIfAutoDismiss() async {
    if (await autoDismiss) await dismiss();
  }

  Future<HomeWhatsNew?> _getWhatsNew() async {
    final homeWidgets = await _homeWidgetRepository.homeWidgetsStream.first;
    final whatsNew = homeWidgets
        .where((homeWidget) => homeWidget.type == HomeWidgetType.whats_new)
        .firstOrNull;
    return whatsNew is HomeWhatsNew ? whatsNew : null;
  }
}
