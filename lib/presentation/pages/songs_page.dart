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
  ReactionDisposer _dispose;
  bool _changeIndicator = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dispose = reaction(
      (_) => widget.store.isUpdatingDatabase,
      (bool isUpdating) {
        if (!isUpdating) {
          setState(() {
            _changeIndicator = !_changeIndicator;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    print('SongsPage.dispose');
    super.dispose();
    _dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('SongsPage.build');

    super.build(context);
    return Observer(builder: (_) {
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
