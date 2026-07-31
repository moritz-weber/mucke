import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import 'domain/actors/persistence_actor.dart';
import 'domain/repositories/init_repository.dart';
import 'domain/repositories/localization_repository.dart';
import 'injection_container.dart';
import 'l10n/localizations.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/init/init_page.dart';
import 'presentation/pages/library_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/state/navigation_store.dart';
import 'presentation/theming.dart';
import 'presentation/widgets/navbar.dart';
import 'system/logging.dart';

final _logger = Logger('Main');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLogging(level: Level.ALL);
  _logger.fine('main: logging initialized');

  _logger.fine('main: entering dependency injection');
  await setupGetIt();
  _logger.fine('main: dependency injection completed');

  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music());
  _logger.fine('main: audio session configured');

  await GetIt.I<PersistenceActor>().init();
  _logger.fine('main: persistence actor initialized');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    // Android Auto starts the audio service without an attached Flutter view.
    // SystemChrome calls can wait indefinitely in that context, so only
    // configure phone UI when this engine actually owns a view.
    if (WidgetsBinding.instance.platformDispatcher.views.isNotEmpty) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    final localizationRepository = getIt<LocalizationRepository>();

    return MaterialApp(
      title: 'mucke',
      theme: theme(),
      initialRoute: '/',
      routes: {
        '/': (context) {
          return const RootPage();
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
      builder: (context, child) {
        localizationRepository.locale = Localizations.localeOf(context);
        return child!;
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
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        final shouldPop = await navStore.onWillPop();
        if (shouldPop && context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: Observer(
        builder: (BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarContrastEnforced: false,
          ),
          child: Scaffold(
            // Android 15 makes the navigation bar transparent. Paint the
            // Scaffold background underneath it as well; otherwise the system
            // navigation area reveals the default scaffold color.
            backgroundColor: DARK1,
            body: IndexedStack(
              index: navStore.navIndex,
              children: _pages,
            ),
            bottomNavigationBar: ColoredBox(
              color: DARK1,
              child: SafeArea(
                top: false,
                child: NavBar(
                  onTap: (int index) => navStore.setNavIndex(index),
                  currentIndex: navStore.navIndex,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
