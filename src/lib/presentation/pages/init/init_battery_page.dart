import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:optimization_battery/optimization_battery.dart';

import '../../state/import_store.dart';
import '../../theming.dart';
import '../../widgets/info_card.dart';

class InitBatteryPage extends StatelessWidget {
  const InitBatteryPage({Key? key, required this.importStore}) : super(key: key);

  final ImportStore importStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context)!.batteryOptimization,
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
            BatteryOptimizationsObserver(builder: (context, isIgnore) {
              return ListTile(
                title: Text(L10n.of(context)!.openBattery),
                subtitle: Text(
                  (isIgnore != null && !isIgnore)
                      ? L10n.of(context)!.disableBattery
                      : L10n.of(context)!.disabledBattery,
                  style: TEXT_SMALL_SUBTITLE,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  OptimizationBattery.openBatteryOptimizationSettings();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
