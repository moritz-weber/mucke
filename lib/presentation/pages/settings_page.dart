import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../state/music_data_store.dart';
import '../theming.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicDataStore store = Provider.of<MusicDataStore>(context);

    return ListView(
      children: [
        Container(
          height: 12.0,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          ),
          child: Text(
            'Library',
            style: TEXT_HEADER,
          ),
        ),
        ListTile(
          title: const Text('Update library'),
          subtitle: Observer(builder: (_) {
            final int artistCount = store.artistStream.value.length;
            final int albumCount = store.albumStream.value.length;
            final int songCount = store.songStream.value.length;
            return Text('$artistCount artists, $albumCount albums, $songCount songs');
          }),
          onTap: () => store.updateDatabase(),
          trailing: Observer(builder: (_) {
            if (store.isUpdatingDatabase) {
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
          title: const Text('Select library folders'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _openFilePicker(store),
        ),
        const Divider(
          height: 4.0,
        ),
      ],
    );
  }

  Future<void> _openFilePicker(MusicDataStore store) async {
    try {
      store.addLibraryFolder(await FilePicker.platform.getDirectoryPath());
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (ex) {
      print(ex);
    }
  }
}
