import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../state/music_data_store.dart';
import '../state/settings_page_store.dart';
import '../theming.dart';
import 'library_folders_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsPageStore settingsPageStore;
  late TextEditingController _controller;
  late ReactionDisposer _dispose;

  @override
  void initState() {
    super.initState();
    settingsPageStore = GetIt.I<SettingsPageStore>();
    settingsPageStore.init();
    settingsPageStore.setupValidations();

    _controller = TextEditingController();
    _controller.addListener(() {
      if (_controller.text != settingsPageStore.blockSkippedSongsThreshold) {
        print('ctrl listener: ${_controller.text}');
        settingsPageStore.blockSkippedSongsThreshold = _controller.text;
      }
    });
    _dispose = autorun((_) {
      if (_controller.text != settingsPageStore.blockSkippedSongsThreshold) {
        print('autorun: ${settingsPageStore.blockSkippedSongsThreshold}');
        _controller.text = settingsPageStore.blockSkippedSongsThreshold;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    settingsPageStore.dispose();
    _dispose();
  }

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
            const ListTile(
              title: Text('Soon (tm)'),
            ),
            const Divider(
              height: 4.0,
            ),
            const SettingsSection(text: 'Customize playback'),
            Observer(
              builder: (_) {
                final bool enabled = settingsPageStore.isBlockSkippedSongsEnabled;

                return Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING, vertical: 4.0),
                      child: Row(
                        children: [
                          const Text('Enable excluding skipped songs from queue'),
                          const Spacer(),
                          Switch(
                            value: settingsPageStore.isBlockSkippedSongsEnabled,
                            onChanged: (bool value) {
                              print('set: $value');
                              settingsPageStore.isBlockSkippedSongsEnabled = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING, vertical: 4.0),
                      child: Row(
                        children: [
                          const Text('Minimum skip count to exclude songs'),
                          const Spacer(),
                          SizedBox(
                            width: 56.0,
                            child: TextFormField(
                              controller: _controller,
                              enabled: enabled,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                errorText: settingsPageStore.error.skipCountThreshold,
                                errorStyle: const TextStyle(height: 0, fontSize: 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
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
