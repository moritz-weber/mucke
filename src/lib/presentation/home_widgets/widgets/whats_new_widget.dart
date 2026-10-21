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
      whatsNewStore.dismissIfAutoDismiss();
      navStore.push(
        context,
        MaterialPageRoute<Widget>(
          builder: (context) => WhatsNewPage(version: version),
        ),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 12.0, right: 8.0),
          onTap: openPage,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.new_releases_rounded,
              size: 40.0,
              color: LIGHT2,
            ),
          ),
          title: Text(
            l10n.whatsNewInVersion(version),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            l10n.whatsNewDescription,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TEXT_SMALL_SUBTITLE,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close_rounded),
            tooltip: l10n.dismiss,
            onPressed: whatsNewStore.dismiss,
          ),
        ),
      ),
    );
  }
}
