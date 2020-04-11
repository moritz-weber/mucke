import 'package:flutter/material.dart';

import 'albums_page.dart';
import 'songs_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    print('LibraryPage.build');
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
