import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/settings_store.dart';
import '../theming.dart';
import 'library_folders_page.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

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
              trailing: const Icon(Icons.chevron_right),
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
            Observer(
              builder: (context) => SwitchListTile(
                value: settingsStore.manageExternalStorageGranted.value ?? false,
                onChanged: settingsStore.setManageExternalStorageGranted,
                title: const Text('Grant permission to manage all files'),
                subtitle: const Text(
                  'This permission can improve library updates in some cases. Revoking the permission will result in a restart of mucke.',
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
        top: 16.0,
        bottom: 4.0,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}
