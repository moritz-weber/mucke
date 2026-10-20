import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/l10n/localizations.dart';

import '../../pages/whats_new_page.dart';
import '../../state/navigation_store.dart';
import '../../state/whats_new_store.dart';
import '../../theming.dart';

class WhatsNewWidget extends StatelessWidget {
  const WhatsNewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final L10n l10n = L10n.of(context)!;
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final WhatsNewStore whatsNewStore = GetIt.I<WhatsNewStore>();

    final version = whatsNewStore.currentVersion;

    void openPage() {
      whatsNewStore.dismiss();
      navStore.push(
        context,
        MaterialPageRoute<Widget>(
          builder: (context) => WhatsNewPage(version: version),
        ),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: openPage,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 4.0, 12.0),
          child: Row(
            children: [
              const Icon(Icons.new_releases_rounded, color: LIGHT2),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.whatsNewInVersion(version),
                      style: TEXT_HEADER_S,
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      l10n.whatsNewDescription,
                      style: TEXT_SMALL_SUBTITLE,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                tooltip: l10n.dismiss,
                onPressed: whatsNewStore.dismiss,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
