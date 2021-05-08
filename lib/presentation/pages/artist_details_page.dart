import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../state/artist_page_store.dart';
import '../state/audio_store.dart';
import '../theming.dart';
import '../widgets/artist_albums.dart';
import '../widgets/artist_header.dart';
import '../widgets/artist_highlighted_songs.dart';
import 'album_details_page.dart';

class ArtistDetailsPage extends StatefulWidget {
  const ArtistDetailsPage({Key key, @required this.artist}) : super(key: key);

  final Artist artist;

  @override
  _ArtistDetailsPageState createState() => _ArtistDetailsPageState();
}

class _ArtistDetailsPageState extends State<ArtistDetailsPage> {
  ArtistPageStore store;

  @override
  void initState() {
    super.initState();

    store = ArtistPageStore(
      musicDataInfoRepository: GetIt.I<MusicDataInfoRepository>(),
      artist: widget.artist,
    );
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) => SafeArea(
        child: CustomScrollView(
          slivers: [
            ArtistHeader(artist: widget.artist),
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
                      onPressed: () => audioStore.shuffleArtist(widget.artist),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: HORIZONTAL_PADDING + 2,
                      right: HORIZONTAL_PADDING + 2,
                      bottom: 4.0,
                    ),
                    child: Text(
                      'Highlights',
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
            ArtistHighlightedSongs(songs: store.artistHighlightedSongStream.value),
            SliverList(
              delegate: SliverChildListDelegate(
                [
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
              albums: store.artistAlbumStream.value,
              onTap: (Album album) => _tapAlbum(album, context),
              onTapPlay: (Album album) => audioStore.playAlbum(album),
            ),
          ],
        ),
      ),
    );
  }

  void _tapAlbum(Album album, BuildContext context) {
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
