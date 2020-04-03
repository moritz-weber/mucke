import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../domain/entities/song.dart';
import '../state/music_store.dart';
import '../widgets/album_art_list_tile.dart';

class SongsPage extends StatefulWidget {
  SongsPage({Key key, @required this.store}) : super(key: key);

  final MusicStore store;

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    print('SongsPageState initState');
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
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
            controller: _scrollController,
            itemCount: songs.length,
            itemBuilder: (_, int index) {
              final Song song = songs[index];
              return AlbumArtListTile(
                key: PageStorageKey(
                    '${song.title}_${song.album}_${song.artist}'),
                title: song.title,
                subtitle: '${song.artist} • ${song.album}',
                albumArtPath: song.albumArtPath,
                onTap: () {},
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        }
      });
}
