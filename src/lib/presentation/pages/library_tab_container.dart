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
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TabBar(
                        indicatorColor: Theme.of(context).highlightColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3.0,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                        unselectedLabelColor: Colors.white30,
                        isScrollable: true,
                        tabs: [
                          Tab(text: L10n.of(context)!.artists),
                          Tab(text: L10n.of(context)!.albums),
                          Tab(text: L10n.of(context)!.songs),
                          Tab(text: L10n.of(context)!.playlists),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  ArtistsPage(key: PageStorageKey('ArtistsPage')),
                  AlbumsPage(key: PageStorageKey('AlbumsPage')),
                  SongsPage(key: PageStorageKey('SongsPage')),
                  PlaylistsPage(key: PageStorageKey('PlaylistsPage'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
