import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/l10n/localizations.dart';

import '../../state/import_store.dart';
import '../../state/settings_store.dart';
import '../../theming.dart';
import '../../widgets/battery_optimization_tile.dart';
import '../../widgets/info_card.dart';

class InitSystemPage extends StatelessWidget {
  const InitSystemPage({
    Key? key,
    required this.importStore,
  }) : super(key: key);

  final ImportStore importStore;

  @override
  Widget build(BuildContext context) {
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context)!.systemSettings,
          style: TEXT_HEADER,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            InfoCard(
              text: L10n.of(context)!.batteryExplanation,
            ),
            const BatteryOptimizationTile(),
            const Divider(
              height: 16.0,
            ),
            InfoCard(
              text: L10n.of(context)!.manageExternalExplanation,
            ),
            Observer(
              builder: (context) => SwitchListTile(
                value:
                    settingsStore.manageExternalStorageGranted.value ?? false,
                onChanged: settingsStore.setManageExternalStorageGranted,
                title: Text(L10n.of(context)!.grantManagePermission),
                subtitle: Text(
                  L10n.of(context)!.managePermissionSubtitle,
                  style: TEXT_SMALL_SUBTITLE,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
