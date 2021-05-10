import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../state/navigation_store.dart';
import 'library_tab_container.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('LibraryPage.build');
    final GlobalKey<NavigatorState> nav = GlobalKey();

    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return WillPopScope(
      child: Navigator(
        key: nav,
        initialRoute: 'library',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case 'library':
              builder = (BuildContext context) => const LibraryTabContainer();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
      onWillPop: () async {
        if (navStore.navIndex == 1) {
          return !await nav.currentState.maybePop();
        }
        return Future.value(true);
      },
    );
  }
}
