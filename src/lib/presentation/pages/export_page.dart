import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/export_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../widgets/settings_section.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({Key? key}) : super(key: key);

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  late final ExportStore _exportStore;
  late final NavigationStore _navStore;

  @override
  void initState() {
    _exportStore = GetIt.I<ExportStore>();
    _navStore = GetIt.I<NavigationStore>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context)!.exportData,
          style: TEXT_HEADER,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => _navStore.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt_rounded),
            onPressed: () => _exportData(context),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(HORIZONTAL_PADDING, 16.0, HORIZONTAL_PADDING, 0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.info_rounded),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      L10n.of(context)!.exportDescription,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SettingsSection(text: L10n.of(context)!.library),
          Observer(builder: (context) {
            return CheckboxListTile(
              title: Text(L10n.of(context)!.songsAlbumsArtists),
              value: _exportStore.selection.songsAlbumsArtists,
              onChanged: (value) => _exportStore.setSongsAlbumsArtists(value ?? false),
            );
          }),
          const Divider(),
          Observer(builder: (context) {
            return CheckboxListTile(
              title: Text(L10n.of(context)!.smartlists),
              value: _exportStore.selection.smartlists,
              onChanged: (value) => _exportStore.setSmartlists(value ?? false),
            );
          }),
          const Divider(),
          Observer(builder: (context) {
            return CheckboxListTile(
              title: Text(L10n.of(context)!.playlists),
              value: _exportStore.selection.playlists,
              onChanged: (value) => _exportStore.setPlaylists(value ?? false),
            );
          }),
          SettingsSection(text: L10n.of(context)!.librarySettings),
          Observer(
            builder: (context) {
              return CheckboxListTile(
                title: Text(L10n.of(context)!.libraryFolders),
                value: _exportStore.selection.libraryFolders,
              onChanged: (value) => _exportStore.setLibraryFolders(value ?? false),
              );
            }
          ),
          const Divider(),
          CheckboxListTile(
            title: Text(L10n.of(context)!.allowedFileExtensions),
            value: true,
            onChanged: (value) => {},
          ),
          const Divider(),
          CheckboxListTile(
            title: Text(L10n.of(context)!.blockedFiles),
            value: true,
            onChanged: (value) => {},
          ),
          const SizedBox(height: HORIZONTAL_PADDING),
        ],
      ),
    );
  }

  Future<void> _exportData(BuildContext context) async {
    try {
      final path = await _exportStore.exportData(await FilePicker.platform.getDirectoryPath());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              if (path != null) const Icon(Icons.check_circle_rounded, color: GREEN),
              if (path == null) const Icon(Icons.warning_rounded, color: RED),
              const SizedBox(width: 16.0),
              if (path != null) Expanded(child: Text(L10n.of(context)!.dataExportedTo(path))),
              if (path == null) Expanded(child: Text(L10n.of(context)!.dataExportFailed)),
            ],
          ),
          duration: const Duration(seconds: 10),
          showCloseIcon: true,
        ),
      );
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (ex) {
      print(ex);
    }
  }
}
