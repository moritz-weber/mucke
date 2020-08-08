import 'package:flutter/material.dart';

import 'albums_page.dart';
import 'artists_page.dart';
import 'songs_page.dart';

class LibraryTabContainer extends StatelessWidget {
  const LibraryTabContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: const TabBar(
                tabs: <Tab>[
                  Tab(
                    text: 'Artists',
                  ),
                  Tab(
                    text: 'Albums',
                  ),
                  Tab(
                    text: 'Songs',
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  ArtistsPage(
                    key: PageStorageKey('ArtistsPage'),
                  ),
                  AlbumsPage(
                    key: PageStorageKey('AlbumsPage'),
                  ),
                  SongsPage(
                    key: PageStorageKey('SongsPage'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}