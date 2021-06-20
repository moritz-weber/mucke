import 'package:flutter/material.dart';

import 'albums_page.dart';
import 'artists_page.dart';
import 'songs_page.dart';

class LibraryTabContainer extends StatelessWidget {
  const LibraryTabContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 4.0),
              child: Row(
                children: [
                  const Expanded(
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 3.0,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      labelPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      unselectedLabelColor: Colors.white30,
                      isScrollable: true,
                      tabs: [
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
                  IconButton(icon: const Icon(Icons.more_vert), onPressed: () => null),
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
