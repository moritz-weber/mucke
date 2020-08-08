import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/artist.dart';
import '../state/music_data_store.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({Key key}) : super(key: key);

  @override
  _ArtistsPageState createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print('ArtistsPage.build');
    final MusicDataStore musicDataStore = Provider.of<MusicDataStore>(context);

    super.build(context);
    return Observer(builder: (_) {
      print('ArtistsPage.build -> Observer.builder');
      final bool isFetching = musicDataStore.isFetchingArtists;

      if (isFetching) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
            Text('Loading items...'),
          ],
        );
      } else {
        final List<Artist> artists = musicDataStore.artists;
        return ListView.separated(
          itemCount: artists.length,
          itemBuilder: (_, int index) {
            final Artist artist = artists[index];
            return ListTile(
              title: Text(artist.name),
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
