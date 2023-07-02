import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../state/import_store.dart';
import '../../theming.dart';
import '../../widgets/settings_section.dart';

class InitMetaPage extends StatelessWidget {
  const InitMetaPage({Key? key, required this.importStore}) : super(key: key);

  final ImportStore importStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context)!.importLibData,
          style: TEXT_HEADER,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Observer(builder: (_) {
            if (importStore.importing) {
              return const LinearProgressIndicator();
            }
            return Container();
          }),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              SettingsSection(text: L10n.of(context)!.songMetaData),
              Observer(builder: (context) {
                final numSongs = importStore.songs?.length ?? 0;
                return ListTile(
                  title: Text(L10n.of(context)!.metaDataAvailable(numSongs)),
                  subtitle: Text(L10n.of(context)!.metaDataDescription),
                  trailing: ElevatedButton(
                    onPressed: importStore.importedMetadata || importStore.importing
                        ? null
                        : () => importStore.importSongMetadata(),
                    child: Text(
                      importStore.importedMetadata
                          ? L10n.of(context)!.imported
                          : L10n.of(context)!.importVerb,
                    ),
                  ),
                );
              }),
              Observer(builder: (context) {
                final smartlists = importStore.smartlists;
                if (smartlists == null || smartlists.isEmpty) return Container();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsSection(text: L10n.of(context)!.smartlists),
                    for (final i in List.generate(smartlists.length, (i) => i))
                      ListTile(
                        title: Text(smartlists[i]),
                        trailing: ElevatedButton(
                          onPressed: importStore.importedSmartlists[i] || importStore.importing
                              ? null
                              : () => importStore.importSmartlist(i),
                          child: Text(
                            importStore.importedSmartlists[i]
                                ? L10n.of(context)!.imported
                                : L10n.of(context)!.importVerb,
                          ),
                        ),
                      ),
                  ],
                );
              }),
              Observer(builder: (context) {
                final playlists = importStore.playlists;
                if (playlists == null || playlists.isEmpty) return Container();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsSection(text: L10n.of(context)!.playlists),
                    for (final i in List.generate(playlists.length, (i) => i))
                      ListTile(
                        title: Text(playlists[i]),
                        trailing: ElevatedButton(
                          onPressed: importStore.importedPlaylists[i] || importStore.importing
                              ? null
                              : () => importStore.importPlaylist(i),
                          child: Text(
                            importStore.importedPlaylists[i]
                                ? L10n.of(context)!.imported
                                : L10n.of(context)!.importVerb,
                          ),
                        ),
                      ),
                  ],
                );
              }),
              const SizedBox(height: HORIZONTAL_PADDING),
            ],
          ),
        ),
      ),
    );
  }
}
