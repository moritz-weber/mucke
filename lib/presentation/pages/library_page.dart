import 'package:flutter/material.dart';

import 'library_tab_container.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('LibraryPage.build');
    final GlobalKey<NavigatorState> nav = GlobalKey();

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
        print('onWillPop');
        return !await nav.currentState.maybePop();
      },
    );
  }
}
