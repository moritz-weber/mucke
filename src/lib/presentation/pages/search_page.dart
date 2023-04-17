import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/playable.dart';
import '../state/audio_store.dart';
import '../state/navigation_store.dart';
import '../state/search_page_store.dart';
import '../theming.dart';
import '../widgets/album_art_list_tile.dart';
import '../widgets/play_shuffle_button.dart';
import '../widgets/playlist_cover.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';
import 'album_details_page.dart';
import 'artist_details_page.dart';
import 'playlist_page.dart';
import 'smart_list_page.dart';

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

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8.0,
        title: Padding(
          padding: const EdgeInsets.only(
            top: 11.0,
            bottom: 8.0,
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: L10n.of(context)!.search,
                hintStyle: TEXT_HEADER.copyWith(color: Colors.white),
                fillColor: Colors.white10,
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  gapPadding: 0.0,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  gapPadding: 0.0,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(
              left: HORIZONTAL_PADDING - 8.0,
              right: HORIZONTAL_PADDING - 8.0,
              bottom: 8.0,
            ),
            child: Observer(
              builder: (context) {
                final artists = searchStore.searchResultsArtists;
                final albums = searchStore.searchResultsAlbums;
                final songs = searchStore.searchResultsSongs;
                final smartlists = searchStore.searchResultsSmartLists;
                final playlists = searchStore.searchResultsPlaylists;

                final artistHeight =
                    artists.length * 56.0 + artists.isNotEmpty.toDouble() * (16.0 + 56.0);
                final albumsHeight =
                    albums.length * 72.0 + albums.isNotEmpty.toDouble() * (16.0 + 56.0);
                final songsHeight =
                    songs.length * 72.0 + songs.isNotEmpty.toDouble() * (16.0 + 56.0);
                final smartListsHeight =
                    smartlists.length * 72.0 + smartlists.isNotEmpty.toDouble() * (16.0 + 56.0);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: artists.isEmpty
                          ? null
                          : () => _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              ),
                      icon: const Icon(Icons.person_rounded),
                    ),
                    IconButton(
                      onPressed: albums.isEmpty
                          ? null
                          : () => _scrollController.animateTo(
                                artistHeight,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              ),
                      icon: const Icon(Icons.album_rounded),
                    ),
                    IconButton(
                      onPressed: songs.isEmpty
                          ? null
                          : () => _scrollController.animateTo(
                                artistHeight + albumsHeight,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              ),
                      icon: const Icon(Icons.audiotrack_rounded),
                    ),
                    IconButton(
                      onPressed: smartlists.isEmpty
                          ? null
                          : () => _scrollController.animateTo(
                                artistHeight + albumsHeight + songsHeight,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              ),
                      icon: const Icon(Icons.auto_awesome_rounded),
                    ),
                    IconButton(
                      onPressed: playlists.isEmpty
                          ? null
                          : () => _scrollController.animateTo(
                                artistHeight + albumsHeight + songsHeight + smartListsHeight,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              ),
                      icon: const Icon(Icons.queue_music_rounded),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      body: Observer(builder: (context) {
        final artists = searchStore.searchResultsArtists;
        final albums = searchStore.searchResultsAlbums;
        final songs = searchStore.searchResultsSongs;
        final smartlists = searchStore.searchResultsSmartLists;
        final playlists = searchStore.searchResultsPlaylists;

        if (_textController.text.isEmpty) {
          return const Center(
            child: Icon(
              Icons.search_rounded,
              size: 192,
              color: Colors.white30,
            ),
          );
        }

        return Scrollbar(
          controller: _scrollController,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              if (artists.isNotEmpty) ...[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: Text(
                          L10n.of(context)!.artists,
                          style: TEXT_HEADER.underlined(
                            textColor: Colors.white,
                            underlineColor: LIGHT1,
                            thickness: 4,
                            distance: 8,
                          ),
                        ),
                      ),
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
                                builder: (BuildContext context) => ArtistDetailsPage(
                                  artist: artist,
                                ),
                              ),
                            );
                          },
                        ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
              if (albums.isNotEmpty) ...[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: Text(
                          L10n.of(context)!.albums,
                          style: TEXT_HEADER.underlined(
                            textColor: Colors.white,
                            underlineColor: LIGHT1,
                            thickness: 4,
                            distance: 8,
                          ),
                        ),
                      ),
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
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
              if (songs.isNotEmpty) ...[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: Text(
                          L10n.of(context)!.songs,
                          style: TEXT_HEADER.underlined(
                            textColor: Colors.white,
                            underlineColor: LIGHT1,
                            thickness: 4,
                            distance: 8,
                          ),
                        ),
                      ),
                      for (int i in songs.asMap().keys)
                        SongListTile(
                          song: songs[i],
                          onTap: () => audioStore.playSong(
                            i,
                            songs,
                            SearchQuery(searchText),
                          ),
                          onTapMore: () => showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => SongBottomSheet(
                              song: songs[i],
                            ),
                          ),
                          onSelect: () {},
                        ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
              if (smartlists.isNotEmpty)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: Text(
                          L10n.of(context)!.smartlists,
                          style: TEXT_HEADER.underlined(
                            textColor: Colors.white,
                            underlineColor: LIGHT1,
                            thickness: 4,
                            distance: 8,
                          ),
                        ),
                      ),
                      for (int i in smartlists.asMap().keys)
                        ListTile(
                          title: Text(smartlists[i].name),
                          leading: PlaylistCover(
                            size: 56,
                            gradient: smartlists[i].gradient,
                            icon: smartlists[i].icon,
                          ),
                          onTap: () => _navStore.pushOnLibrary(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SmartListPage(smartList: smartlists[i]),
                            ),
                          ),
                          trailing: PlayShuffleButton(
                            size: 40.0,
                            shuffleMode: smartlists[i].shuffleMode,
                            onPressed: () => audioStore.playSmartList(smartlists[i]),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(HORIZONTAL_PADDING, 8.0, 4.0, 8.0),
                        ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              if (playlists.isNotEmpty)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: Text(
                          L10n.of(context)!.playlists,
                          style: TEXT_HEADER.underlined(
                            textColor: Colors.white,
                            underlineColor: LIGHT1,
                            thickness: 4,
                            distance: 8,
                          ),
                        ),
                      ),
                      for (int i in playlists.asMap().keys)
                        ListTile(
                          title: Text(playlists[i].name),
                          leading: PlaylistCover(
                            size: 56,
                            gradient: playlists[i].gradient,
                            icon: playlists[i].icon,
                          ),
                          onTap: () => _navStore.pushOnLibrary(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PlaylistPage(playlist: playlists[i]),
                            ),
                          ),
                          trailing: PlayShuffleButton(
                            size: 40.0,
                            onPressed: () => audioStore.playPlaylist(playlists[i]),
                            shuffleMode: playlists[i].shuffleMode,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(HORIZONTAL_PADDING, 8.0, 4.0, 8.0),
                        ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

extension BoolToDouble on bool {
  double toDouble() => this ? 1.0 : 0.0;
}
