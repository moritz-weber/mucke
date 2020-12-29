import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../state/music_data_store.dart';
import '../widgets/album_art_list_tile.dart';
import 'album_details_page.dart';

class ArtistDetailsPage extends StatelessWidget {
  const ArtistDetailsPage({Key key, @required this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = Provider.of<MusicDataStore>(context);

    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (BuildContext context) => ListView.separated(
            itemCount: musicDataStore.artistAlbumStream.value.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 4.0,
            ),
            itemBuilder: (_, int index) {
              final Album album = musicDataStore.artistAlbumStream.value[index];
              return AlbumArtListTile(
                title: album.title,
                subtitle: album.pubYear.toString(),
                albumArtPath: album.albumArtPath,
                onTap: () {
                  musicDataStore.fetchSongsFromAlbum(album);
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
          ),
        ),
      ),
    );
  }
}
