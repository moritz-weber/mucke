import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/artist.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import 'artist_details_page.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({Key? key}) : super(key: key);

  @override
  _ArtistsPageState createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    print('ArtistsPage.build');
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    super.build(context);
    return Observer(builder: (_) {
      print('ArtistsPage.build -> Observer.builder');
      final List<Artist> artists = musicDataStore.artistStream.value ?? [];
      return Scrollbar(
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          itemCount: artists.length,
          itemBuilder: (_, int index) {
            final Artist artist = artists[index];
            return ListTile(
              title: Text(artist.name),
              onTap: () {
                navStore.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext context) => ArtistDetailsPage(
                      artist: artist,
                    ),
                  ),
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 4.0,
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
