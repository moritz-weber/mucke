import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/playable.dart';
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

    final ScrollController _scrollController = ScrollController();
    final TextEditingController _textController = TextEditingController();

    String searchText = '';

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
            child: StatefulBuilder(builder: (context, setState) {
              return TextField(
                controller: _textController,
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
                  suffixIcon: searchText.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              searchText = '';
                              _textController.text = '';
                            });
                            searchStore.reset();
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                onChanged: (text) {
                  setState(() => searchText = text);
                  searchStore.search(text);
                },
                focusNode: _searchFocus,
              );
            }),
          ),
          Expanded(
            child: Observer(builder: (context) {
              final artists = searchStore.searchResultsArtists;
              final albums = searchStore.searchResultsAlbums;
              final songs = searchStore.searchResultsSongs;

              final viewArtists = searchStore.viewArtists;
              final viewAlbums = searchStore.viewAlbums;
              final viewSongs = searchStore.viewSongs;

              return Scrollbar(
                controller: _scrollController,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    if (artists.isNotEmpty) ...[
                      SliverAppBar(
                        title: GestureDetector(
                          onTap: () => _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                          ),
                          child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text('Artists', style: TEXT_HEADER),
                            ),
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () => searchStore.toggleViewArtists(),
                            icon: Icon(viewArtists
                                ? Icons.expand_less_rounded
                                : Icons.expand_more_rounded),
                          ),
                        ],
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        elevation: 0.0,
                        pinned: true,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) => SizeTransition(
                                sizeFactor: animation,
                                child: child,
                              ),
                              child: viewArtists
                                  ? Column(
                                      children: [
                                        for (final artist in artists)
                                          ListTile(
                                            title: Text(artist.name),
                                            leading: const SizedBox(
                                              child: Icon(Icons.person_rounded),
                                              width: 56.0,
                                              height: 56.0,
                                            ),
                                            onTap: () {
                                              _navStore.pushOnLibrary(
                                                MaterialPageRoute<Widget>(
                                                  builder: (BuildContext context) =>
                                                      ArtistDetailsPage(
                                                    artist: artist,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (albums.isNotEmpty) ...[
                      SliverAppBar(
                        title: GestureDetector(
                          onTap: () {
                            _scrollController.animateTo(
                              artists.length * 56.0 * viewArtists.toDouble(),
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text('Albums', style: TEXT_HEADER),
                            ),
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () => searchStore.toggleViewAlbums(),
                            icon: Icon(
                              viewAlbums ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                            ),
                          ),
                        ],
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        elevation: 0.0,
                        pinned: true,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) => SizeTransition(
                                sizeFactor: animation,
                                child: child,
                              ),
                              child: viewAlbums
                                  ? Column(children: [
                                      for (final album in albums)
                                        AlbumArtListTile(
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
                                        ),
                                    ])
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (songs.isNotEmpty) ...[
                      SliverAppBar(
                        title: GestureDetector(
                          onTap: () {
                            _scrollController.animateTo(
                              artists.length * 56.0 * viewArtists.toDouble() +
                                  albums.length * 72.0 * viewAlbums.toDouble(),
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text('Songs', style: TEXT_HEADER),
                            ),
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () => searchStore.toggleViewSongs(),
                            icon: Icon(
                              viewSongs ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                            ),
                          ),
                        ],
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        elevation: 0.0,
                        pinned: true,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) => SizeTransition(
                                sizeFactor: animation,
                                child: child,
                              ),
                              child: viewSongs
                                  ? Column(children: [
                                      for (final song in songs)
                                        SongListTile(
                                          song: song,
                                          onTap: () => audioStore.playSong(
                                            0,
                                            [song],
                                            SearchQuery(searchText),
                                          ),
                                          onTapMore: () => showModalBottomSheet(
                                            context: context,
                                            useRootNavigator: true,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) => SongBottomSheet(
                                              song: song,
                                            ),
                                          ),
                                        ),
                                    ])
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

extension BoolToDouble on bool {
  double toDouble() => this ? 1.0 : 0.0;
}
