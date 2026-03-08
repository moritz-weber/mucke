import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mucke/system/logging.dart';

import 'domain/actors/persistence_actor.dart';
import 'domain/repositories/init_repository.dart';
import 'injection_container.dart';
import 'l10n/localizations.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/init/init_page.dart';
import 'presentation/pages/library_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/state/navigation_store.dart';
import 'presentation/theming.dart';
import 'presentation/widgets/navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLogging(level: Level.ALL);

  await setupGetIt();

  MetadataGod.initialize();
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music());

  await GetIt.I<PersistenceActor>().init();

  // mainContext.config = mainContext.config.clone(
  //   isSpyEnabled: true,
  // );

  // mainContext.spy(print);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
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
        '/': (context) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            child: const RootPage(),
            value: SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarColor: DARK1,
              statusBarIconBrightness: Brightness.light,
            ),
          );
        },
      },
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('ca'),
        Locale('zh'),
        Locale('fi'),
        Locale('fr'),
        Locale('de'),
        Locale('it'),
        Locale('nb'),
        Locale('ru'),
        Locale('es'),
        Locale('uk'),
      ],
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
    // TODO: this does not conform to the design that UI should only call stores, but this would seem overkill
    final initRepository = GetIt.I<InitRepository>();

    initRepository.isInitialized.then((value) {
      if (!value) {
        navStore.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => const PopScope(
              canPop: false,
              child: InitPage(),
            ),
          ),
        );

        initRepository.initHomePage(context);
      }
    });

    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) {
        navStore.onWillPop();
      },
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
      
    );
  }
}
