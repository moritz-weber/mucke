import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../state/music_store.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key, @required this.store}) : super(key: key);

  final MusicStore store;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          ),
          child: Text(
            'Library',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        ListTile(
          title: const Text('Update library'),
          subtitle: Observer(builder: (_) {
            final ObservableFuture<List<Album>> albumsFuture =
                store.albumsFuture;
            final bool isFetchingSongs = store.isFetchingSongs;
            if (albumsFuture.status == FutureStatus.fulfilled &&
                !isFetchingSongs) {
              final int albumCount = (albumsFuture.result as List).length;
              final int songCount = store.songs.length;
              return Text('XX artists, $albumCount albums, $songCount songs');
            }
            return const Text('');
          }),
          onTap: () {
            store.updateDatabase();
          },
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
          title: Text('Select library folders'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {},
        ),
        const Divider(
          height: 4.0,
        ),
      ],
    );
  }
}
