import 'package:flutter/material.dart';

import 'albums_page.dart';
import 'songs_page.dart';

class LibraryTabContainer extends StatelessWidget {
  const LibraryTabContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Column(
          children: const <Widget>[
            TabBar(
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
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Center(
                    child: Text('Artists'),
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