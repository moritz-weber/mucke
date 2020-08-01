import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/album.dart';
import '../state/music_data_store.dart';
import '../widgets/album_art_list_tile.dart';
import 'album_details_page.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key key}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print('AlbumsPage.build');
    final MusicDataStore store = Provider.of<MusicDataStore>(context);

    super.build(context);
    return Observer(builder: (_) {
      print('AlbumsPage.build -> Observer.builder');
      final bool isFetching = store.isFetchingAlbums;

      if (isFetching) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
            Text('Loading items...'),
          ],
        );
      } else {
        final List<Album> albums = store.albums;
        return ListView.separated(
          itemCount: albums.length,
          itemBuilder: (_, int index) {
            final Album album = albums[index];
            return AlbumArtListTile(
              title: album.title,
              subtitle: album.artist,
              albumArtPath: album.albumArtPath,
              onTap: () {
                store.fetchSongsFromAlbum(album);
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext context) => AlbumDetailsPage(
                      album: album,
                    ),
                  ),
                );
              },
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
