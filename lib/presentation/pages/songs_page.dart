import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../widgets/album_art_list_tile.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({Key key}) : super(key: key);

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    print('SongsPage.build');
    final MusicDataStore musicDataStore = Provider.of<MusicDataStore>(context);
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    super.build(context);
    return Observer(builder: (_) {
      print('SongsPage.build -> Observer.builder');
      final bool isFetching = musicDataStore.isFetchingSongs;

      if (isFetching) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
            Text('Loading items...'),
          ],
        );
      } else {
        final List<Song> songs = musicDataStore.songs;
        return ListView.separated(
          itemCount: songs.length,
          itemBuilder: (_, int index) {
            final Song song = songs[index];
            return AlbumArtListTile(
              title: song.title,
              subtitle: '${song.artist} • ${song.album}',
              albumArtPath: song.albumArtPath,
              onTap: () => audioStore.playSong(index, songs),
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
