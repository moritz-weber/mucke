import 'package:flutter/material.dart';

import '../state/music_store.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key, @required this.store}) : super(key: key);

  final MusicStore store;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Update database'),
          onTap: () {
            store.updateDatabase();
          },
        )
      ],
    );
  }
}
