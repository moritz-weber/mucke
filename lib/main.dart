import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:mosh/system/datasources/local_music_fetcher.dart';
import 'package:mosh/system/datasources/moor_music_data_source.dart';
import 'package:mosh/system/repositories/music_data_repository_impl.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/home_page.dart';
import 'presentation/pages/library_page.dart';
import 'presentation/pages/settings_page.dart';
import 'presentation/state/music_store.dart';
import 'presentation/theming.dart';
import 'presentation/widgets/navbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'mosh',
      theme: theme(),
      home: Provider<MusicStore>(
        child: RootPage(),
        create: (BuildContext context) => MusicStore(
          MusicDataRepositoryImpl(
            localMusicFetcher: LocalMusicFetcherImpl(FlutterAudioQuery()),
            musicDataSource: MoorMusicDataSource(),
          ),
        ),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var navIndex = 0;

  List<Widget> _pages;
  MusicStore _musicStore;

  @override
  void didChangeDependencies() {
    _musicStore = Provider.of<MusicStore>(context);
    _musicStore.fetchAlbums();
    _musicStore.fetchSongs();

    _pages = <Widget>[
      HomePage(),
      LibraryPage(
        key: const PageStorageKey('LibraryPage'),
        store: _musicStore,
      ),
      SettingsPage(
        key: const PageStorageKey('SettingsPage'),
        store: _musicStore,
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: navIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavBar(
        onTap: (int index) {
          setState(() {
            navIndex = index;
          });
        },
        currentIndex: navIndex,
      ),
    );
  }
}
