import 'package:battery_optimization_helper/battery_optimization_helper.dart';
import 'package:flutter/material.dart';
import 'package:mucke/l10n/localizations.dart';

import '../theming.dart';

class BatteryOptimizationTile extends StatefulWidget {
  const BatteryOptimizationTile({super.key});

  @override
  State<BatteryOptimizationTile> createState() => _BatteryOptimizationTileState();
}

class _BatteryOptimizationTileState extends State<BatteryOptimizationTile>
    with WidgetsBindingObserver {
  late Future<BatteryRestrictionSnapshot> _future;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _future = BatteryOptimizationHelper.getBatteryRestrictionSnapshot();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _future = BatteryOptimizationHelper.getBatteryRestrictionSnapshot();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BatteryRestrictionSnapshot>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final data = snapshot.data!;
        final isEnabled = data.isBatteryOptimizationEnabled;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                isEnabled ? L10n.of(context)!.disableBattery : L10n.of(context)!.disabledBattery,
              ),
              subtitle: isEnabled
                  ? Text(
                      L10n.of(context)!.disableBatteryDescription,
                      style: TEXT_SMALL_SUBTITLE,
                    )
                  : null,
              trailing: isEnabled
                  ? const Icon(Icons.chevron_right_rounded)
                  : const Icon(Icons.check_rounded),
              onTap: () async {
                await BatteryOptimizationHelper.ensureOptimizationDisabledDetailed(
                  openSettingsIfDirectRequestNotPossible: true,
                );
                // Refresh after returning from the dialog/settings
                setState(() {
                  _future = BatteryOptimizationHelper.getBatteryRestrictionSnapshot();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
