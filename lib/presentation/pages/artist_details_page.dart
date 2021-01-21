import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../theming.dart';
import '../widgets/artist_albums.dart';
import '../widgets/artist_header.dart';
import 'album_details_page.dart';

class ArtistDetailsPage extends StatelessWidget {
  const ArtistDetailsPage({Key key, @required this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = Provider.of<MusicDataStore>(context);
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) => SafeArea(
        child: CustomScrollView(
          slivers: [
            ArtistHeader(artist: artist),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: HORIZONTAL_PADDING,
                      right: HORIZONTAL_PADDING,
                      bottom: 8.0,
                    ),
                    child: ElevatedButton(
                      child: const Text('SHUFFLE'),
                      onPressed: () => audioStore.shuffleArtist(artist),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: HORIZONTAL_PADDING + 2,
                      right: HORIZONTAL_PADDING + 2,
                      bottom: 4.0,
                    ),
                    child: Text(
                      'Albums',
                      style: TEXT_HEADER,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HORIZONTAL_PADDING,
                      vertical: 4.0,
                    ),
                    child: Container(
                      height: 1.0,
                      color: Colors.white10,
                    ),
                  ),
                ],
              ),
            ),
            ArtistAlbumSliverList(
              albums: musicDataStore.sortedArtistAlbums,
              onTap: (Album album) => _tapAlbum(album, context, musicDataStore),
              onTapPlay: (Album album) => audioStore.playAlbum(album),
            ),
          ],
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
