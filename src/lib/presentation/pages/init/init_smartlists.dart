import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../state/import_store.dart';
import '../../theming.dart';
import '../../widgets/info_card.dart';

class InitSmartlistsPage extends StatelessWidget {
  const InitSmartlistsPage({Key? key, required this.importStore}) : super(key: key);

  final ImportStore importStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context)!.createSmartlists,
          style: TEXT_HEADER,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            InfoCard(
              text: L10n.of(context)!.createSmartlistsDesc,
            ),
            Observer(builder: (context) {
              return ListTile(
                title: Text(L10n.of(context)!.favorites),
                subtitle: Text(L10n.of(context)!.favoritesDesc),
                trailing: ElevatedButton(
                  child: importStore.createdFavorites
                      ? Text(L10n.of(context)!.created)
                      : Text(L10n.of(context)!.create),
                  onPressed: importStore.createdFavorites
                      ? null
                      : () => importStore.createFavorites(context),
                ),
              );
            }),
            Observer(builder: (context) {
              return ListTile(
                title: Text(L10n.of(context)!.newlyAdded),
                subtitle: Text(L10n.of(context)!.newlyAddedDesc),
                trailing: ElevatedButton(
                  child: importStore.createdNewlyAdded
                      ? Text(L10n.of(context)!.created)
                      : Text(L10n.of(context)!.create),
                  onPressed: importStore.createdNewlyAdded
                      ? null
                      : () => importStore.createNewlyAdded(context),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
