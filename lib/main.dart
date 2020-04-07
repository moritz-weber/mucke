import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mosh/presentation/widgets/injection_widget.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/home_page.dart';
import 'presentation/pages/library_page.dart';
import 'presentation/pages/settings_page.dart';
import 'presentation/state/music_data_store.dart';
import 'presentation/theming.dart';
import 'presentation/widgets/audio_service_widget.dart';
import 'presentation/widgets/navbar.dart';
import 'system/datasources/audio_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'mucke',
      theme: theme(),
      home: const AudioServiceWidget(
        child: InjectionWidget(
          child: RootPage(),
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

  final List<Widget> _pages = <Widget>[
    HomePage(),
    const LibraryPage(
      key: PageStorageKey('LibraryPage'),
    ),
    const SettingsPage(
      key: PageStorageKey('SettingsPage'),
    ),
  ];

  @override
  void didChangeDependencies() {
    final MusicDataStore _musicStore = Provider.of<MusicDataStore>(context);
    _musicStore.fetchAlbums();
    _musicStore.fetchSongs();

    // TODO: don't do this here...
    AudioService.start(backgroundTaskEntrypoint: _backgroundTaskEntrypoint);

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

void _backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
