import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../defaults.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/settings_store.dart';
import '../theming.dart';
import 'blocked_files_page.dart';
import 'library_folders_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    final TextEditingController _textController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TEXT_HEADER,
          ),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: () => navStore.pop(context),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            const SettingsSection(text: 'Library'),
            ListTile(
              title: const Text('Update library'),
              subtitle: Observer(builder: (_) {
                final int artistCount = musicDataStore.artistStream.value?.length ?? 0;
                final int albumCount = musicDataStore.albumStream.value?.length ?? 0;
                final int songCount = musicDataStore.songStream.value?.length ?? 0;
                return Text('$artistCount artists, $albumCount albums, $songCount songs');
              }),
              onTap: () => musicDataStore.updateDatabase(),
              trailing: Observer(builder: (_) {
                if (musicDataStore.isUpdatingDatabase) {
                  return const CircularProgressIndicator();
                }
                return Container(
                  height: 0,
                  width: 0,
                );
              }),
            ),
            const Divider(
              height: 4.0,
            ),
            ListTile(
              title: const Text('Manage library folders'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => navStore.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LibraryFoldersPage(),
                ),
              ),
            ),
            const Divider(
              height: 4.0,
            ),
            const ListTile(
              title: Text('Allowed file extensions'),
              subtitle: Text('Comma-separated list. Lower- or uppercase does not matter.'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: HORIZONTAL_PADDING,
                right: HORIZONTAL_PADDING,
                bottom: 16.0,
              ),
              child: Observer(
                builder: (context) {
                  final text = settingsStore.fileExtensionsStream.value;
                  if (text == null) return Container();
                  if (_textController.text == '') _textController.text = text;

                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _textController,
                          onChanged: (value) => settingsStore.setFileExtensions(value),
                          textAlign: TextAlign.start,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: DARK35,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                            errorStyle: TextStyle(height: 0, fontSize: 0),
                            contentPadding: EdgeInsets.only(
                              top: 0.0,
                              bottom: 0.0,
                              left: 6.0,
                              right: 6.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      IconButton(
                        icon: const Icon(Icons.settings_backup_restore_rounded),
                        onPressed: () {
                          _textController.text = ALLOWED_FILE_EXTENSIONS;
                          settingsStore.setFileExtensions(ALLOWED_FILE_EXTENSIONS);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(
              height: 4.0,
            ),
            Observer(
              builder: (_) {
                final blockedFiles = settingsStore.numBlockedFiles;

                return ListTile(
                title: const Text('Manage blocked files'),
                subtitle: Text('Number of currently blocked files: $blockedFiles'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => navStore.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const BlockedFilesPage(),
                  ),
                ),
              );},
            ),
            const Divider(
              height: 4.0,
            ),
            Observer(
              builder: (context) => SwitchListTile(
                value: settingsStore.manageExternalStorageGranted.value ?? false,
                onChanged: settingsStore.setManageExternalStorageGranted,
                title: const Text('Grant permission to manage all files'),
                subtitle: const Text(
                  'This permission can improve library updates in some cases. Revoking the permission will result in a restart of the app.',
                  style: TEXT_SMALL_SUBTITLE,
                ),
                isThreeLine: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  const SettingsSection({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 24.0,
        bottom: 4.0,
      ),
      child: Text(
        text,
        style: TEXT_HEADER.underlined(
          textColor: Colors.white,
          underlineColor: LIGHT1,
          thickness: 4,
          distance: 8,
        ),
      ),
    );
  }
}
