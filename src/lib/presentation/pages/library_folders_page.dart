import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/navigation_store.dart';
import '../state/settings_store.dart';
import '../theming.dart';

class LibraryFoldersPage extends StatelessWidget {
  const LibraryFoldersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            L10n.of(context)!.libraryFolders,
            style: TEXT_HEADER,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: () => navStore.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_rounded), 
              onPressed: () => _openFilePicker(settingsStore),
            ),
          ],
          titleSpacing: 0.0,
        ),
        body: Observer(
          builder: (context) {
            final folders = settingsStore.libraryFoldersStream.value ?? [];
            return ListView.separated(
              itemCount: folders.length,
              itemBuilder: (_, int index) {
                final String path = folders[index];
                return ListTile(
                  title: Text(path),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: () => settingsStore.removeLibraryFolder(path),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const SizedBox(
                height: 4.0,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _openFilePicker(SettingsStore store) async {
    try {
      store.addLibraryFolder(await FilePicker.platform.getDirectoryPath());
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (ex) {
      print(ex);
    }
  }
}
