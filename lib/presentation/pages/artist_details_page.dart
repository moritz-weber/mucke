import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../state/music_data_store.dart';
import '../widgets/artist_albums.dart';
import 'album_details_page.dart';

class ArtistDetailsPage extends StatelessWidget {
  const ArtistDetailsPage({Key key, @required this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = Provider.of<MusicDataStore>(context);

    return Observer(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(artist.name),
        ),
        body: SafeArea(
          child: ArtistAlbumList(
            albums: musicDataStore.sortedArtistAlbums,
            onTap: (Album album) => _tapAlbum(album, context, musicDataStore),
          ),
        ),
      ),
    );
  }

  void _tapAlbum(Album album, BuildContext context, MusicDataStore musicDataStore) {
    musicDataStore.fetchSongsFromAlbum(album);
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => AlbumDetailsPage(
          album: album,
        ),
      ),
    );
  }
}
