import 'package:flutter/material.dart';

import '../state/music_store.dart';
import 'albums_page.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key key, @required this.store}) : super(key: key);

  final MusicStore store;

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const TabBar(
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
                    const Center(child: Text('Artists')),
                    AlbumsPage(store: store),
                    const Center(child: Text('Songs')),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
