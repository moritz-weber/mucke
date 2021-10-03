import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../state/music_data_store.dart';
import '../theming.dart';
import 'library_folders_page.dart';
import 'smart_lists_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TEXT_HEADER,
          ),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0.0,
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
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const LibraryFoldersPage(),
                ),
              ),
            ),
            const Divider(
              height: 4.0,
            ),
            const SettingsSection(text: 'Home page'),
            ListTile(
              title: const Text('Customize smart lists'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const SmartListsSettingsPage(),
                ),
              ),
            ),
            const Divider(
              height: 4.0,
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
