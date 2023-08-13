import 'package:audio_session/audio_session.dart';
import 'package:fimber_io/fimber_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:path_provider/path_provider.dart';

import 'domain/actors/persistence_actor.dart';
import 'domain/repositories/init_repository.dart';
import 'injection_container.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/init/init_page.dart';
import 'presentation/pages/library_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/state/navigation_store.dart';
import 'presentation/theming.dart';
import 'presentation/widgets/navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getExternalStorageDirectory();
  Fimber.plantTree(TimedRollingFileTree(
    filenamePrefix: '${dir?.path}/logs/',
  ));
  Fimber.plantTree(DebugTree());

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
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('de'),
        Locale('ca'),
        Locale('nb'),
        Locale('es'),
        Locale('ru'),
        Locale('uk')
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
            builder: (BuildContext context) => WillPopScope(
              onWillPop: () async => false,
              child: const InitPage(),
            ),
          ),
        );

        initRepository.initHomePage(context);
      }
    });

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
