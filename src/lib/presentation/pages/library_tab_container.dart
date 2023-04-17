import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import 'albums_page.dart';
import 'artists_page.dart';
import 'playlists_page.dart';
import 'songs_page.dart';

class LibraryTabContainer extends StatelessWidget {
  const LibraryTabContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 8.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Theme.of(context).highlightColor,
                      width: 3.0,
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 3.0),
                  unselectedLabelColor: Colors.white30,
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: L10n.of(context)!.artists),
                    Tab(text: L10n.of(context)!.albums),
                    Tab(text: L10n.of(context)!.songs),
                    Tab(text: L10n.of(context)!.playlists),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            ArtistsPage(key: PageStorageKey('ArtistsPage')),
            AlbumsPage(key: PageStorageKey('AlbumsPage')),
            SongsPage(key: PageStorageKey('SongsPage')),
            PlaylistsPage(key: PageStorageKey('PlaylistsPage'))
          ],
        ),
      ),
    );
  }
}
