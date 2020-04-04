import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/song.dart';
import '../state/music_store.dart';
import '../widgets/album_art_list_tile.dart';

class SongsPage extends StatefulWidget {
  SongsPage({Key key, @required this.store}) : super(key: key);

  final MusicStore store;

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    print('SongsPage.build');

    super.build(context);
    return Observer(builder: (_) {
      print('SongsPage.build -> Observer.builder');
      final bool isFetching = widget.store.isFetchingSongs;

      if (isFetching) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
            Text('Loading items...'),
          ],
        );
      } else {
        final List<Song> songs = widget.store.songs;
        return ListView.separated(
          itemCount: songs.length,
          itemBuilder: (_, int index) {
            final Song song = songs[index];
            return AlbumArtListTile(
              title: song.title,
              subtitle: '${song.artist} • ${song.album}',
              albumArtPath: song.albumArtPath,
              onTap: () {},
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 4.0,
          ),
        );
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
