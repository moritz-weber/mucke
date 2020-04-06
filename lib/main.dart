import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/home_page.dart';
import 'presentation/pages/library_page.dart';
import 'presentation/pages/settings_page.dart';
import 'presentation/state/music_store.dart';
import 'presentation/theming.dart';
import 'presentation/widgets/audio_service_widget.dart';
import 'presentation/widgets/navbar.dart';
import 'system/datasources/audio_manager.dart';
import 'system/datasources/local_music_fetcher.dart';
import 'system/datasources/moor_music_data_source.dart';
import 'system/repositories/audio_repository_impl.dart';
import 'system/repositories/music_data_repository_impl.dart';

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
      home: AudioServiceWidget(
        child: Provider<MusicStore>(
          child: const RootPage(),
          create: (BuildContext context) => MusicStore(
            musicDataRepository: MusicDataRepositoryImpl(
              localMusicFetcher: LocalMusicFetcherImpl(FlutterAudioQuery()),
              musicDataSource: MoorMusicDataSource(),
            ),
            audioRepository: AudioRepositoryImpl(AudioManagerImpl()),
          ),
        ),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);

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

    AudioService.start(backgroundTaskEntrypoint: _backgroundTaskEntrypoint);

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
  void dispose() {
    AudioService.stop();
    super.dispose();
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

void _backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
