import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/playable.dart';
import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/navigation_store.dart';
import '../state/search_page_store.dart';
import '../theming.dart';
import '../widgets/album_art_list_tile.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';
import 'album_details_page.dart';
import 'artist_details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final NavigationStore _navStore;
  late final ReactionDisposer _disposer;
  late final FocusNode _searchFocus;

  @override
  void initState() {
    super.initState();
    _searchFocus = FocusNode();
    _navStore = GetIt.I<NavigationStore>();
    _disposer = reaction(
      (_) => _navStore.navIndex,
      (int index) {
        if (index != 2) {
          if (_searchFocus.hasFocus) _searchFocus.unfocus();
        }
      },
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('SearchPage.build');

    final searchStore = GetIt.I<SearchPageStore>();
    final audioStore = GetIt.I<AudioStore>();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: HORIZONTAL_PADDING - 8.0,
              right: HORIZONTAL_PADDING - 8.0,
              bottom: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TEXT_HEADER.copyWith(color: Colors.white),
                fillColor: Colors.white10,
                filled: true,
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none, gapPadding: 0.0),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none, gapPadding: 0.0),
                contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              ),
              onChanged: (text) {
                searchStore.search(text);
              },
              focusNode: _searchFocus,
            ),
          ),
          Expanded(
            child: Observer(builder: (context) {
              final results = searchStore.searchResults;
              if (results.isEmpty) return Container();

              return ListView.builder(
                itemBuilder: (context, index) {
                  if (results[index] is Song) {
                    final song = results[index] as Song;
                    return SongListTile(
                      song: song,
                      onTap: () => audioStore.playSong(
                          0, [song], SearchQuery('query')), // TODO: include correct query
                      onTapMore: () => showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => SongBottomSheet(
                          song: song,
                        ),
                      ),
                    );
                  } else if (results[index] is Album) {
                    final album = results[index] as Album;
                    return AlbumArtListTile(
                      title: album.title,
                      subtitle: album.artist,
                      albumArtPath: album.albumArtPath,
                      onTap: () {
                        _navStore.pushOnLibrary(
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) => AlbumDetailsPage(
                              album: album,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (results[index] is Artist) {
                    final artist = results[index] as Artist;
                    return ListTile(
                      title: Text(artist.name),
                      onTap: () {
                        _navStore.pushOnLibrary(
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) => ArtistDetailsPage(
                              artist: artist,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
                itemCount: results.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}
