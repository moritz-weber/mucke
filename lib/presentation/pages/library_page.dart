import 'package:flutter/material.dart';

import '../state/music_store.dart';
import 'albums_page.dart';
import 'songs_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key key, @required this.store}) : super(key: key);

  final MusicStore store;

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('LibraryPage.build');
    return SafeArea(
      child: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
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
              controller: _tabController,
              children: <Widget>[
                Center(
                  key: PageStorageKey('ArtistsPage'),
                  child: Text('Artists'),
                ),
                AlbumsPage(
                  key: const PageStorageKey('AlbumsPage'),
                  store: widget.store,
                ),
                SongsPage(
                  key: const PageStorageKey('SongsPage'),
                  store: widget.store,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
