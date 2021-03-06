import 'package:audio_session/audio_session.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fimber_filelogger/flutter_fimber_filelogger.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'presentation/pages/search_page.dart';

import 'domain/actors/persistence_actor.dart';
import 'injection_container.dart';
import 'presentation/pages/currently_playing.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/library_page.dart';
import 'presentation/pages/settings_page.dart';
import 'presentation/state/navigation_store.dart';
import 'presentation/theming.dart';
import 'presentation/widgets/navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();

  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music());

  Fimber.plantTree(
    FileLoggerTree(
      levels: FileLoggerLevels.ALL,
      numberOfDays: 10,
      logDateFormat: 'HH:mm:ss',
    ),
  );
  Fimber.plantTree(DebugTree());

  await GetIt.I<PersistenceActor>().init();

  runApp(MyApp());
}

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
      initialRoute: '/',
      routes: {
        '/': (context) => const RootPage(),
        '/playing': (context) => const CurrentlyPlayingPage(),
      },
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const LibraryPage(
      key: PageStorageKey('LibraryPage'),
    ),
    const SearchPage(
      key: PageStorageKey('SearchPage'),
    ),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    print('RootPage.build');
    return WillPopScope(
      child: Observer(
        builder: (BuildContext context) => Scaffold(
          body: IndexedStack(
            index: navStore.navIndex,
            children: _pages,
          ),
          bottomNavigationBar: NavBar(
            onTap: (int index) => navStore.setNavIndex(index),
            currentIndex: navStore.navIndex,
          ),
        ),
      ),
      onWillPop: () => navStore.onWillPop(),
    );
  }
}
