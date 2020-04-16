import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/album.dart';
import '../state/music_data_store.dart';
import '../widgets/album_art_list_tile.dart';
import 'album_details_page.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
        print('AlbumsPage.build');
        final MusicDataStore store = Provider.of<MusicDataStore>(context);
        final ObservableFuture<List<Album>> future = store.albumsFuture;

        switch (future.status) {
          case FutureStatus.pending:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                CircularProgressIndicator(),
                Text('Loading items...'),
              ],
            );

          case FutureStatus.rejected:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'Failed to load items.',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            );

          case FutureStatus.fulfilled:
            final List<Album> albums = future.result as List<Album>;
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
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 4.0,
              ),
            );
        }
        return const Center(
          child: Text('Library Page'),
        );
      });
}
