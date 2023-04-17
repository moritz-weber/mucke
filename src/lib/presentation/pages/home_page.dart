import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../home_widgets/home_widget_repr.dart';
import '../state/home_page_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import 'home_settings_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return Navigator(
      key: navStore.homeNavKey,
      initialRoute: 'home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'home':
            builder = (BuildContext context) => const _HomePageInner();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class _HomePageInner extends StatelessWidget {
  const _HomePageInner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = GetIt.I<HomePageStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();

    print('HomePage.build');
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            tooltip: L10n.of(context)!.customizeHomePage,
            onPressed: () => navStore.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeSettingsPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: L10n.of(context)!.settings,
            onPressed: () => navStore.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          final songListIsEmpty = musicDataStore.songListIsEmpty;
          if (songListIsEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.music_note_rounded, size: 64.0),
                    const SizedBox(height: 24.0),
                    Text(
                      L10n.of(context)!.noSongsYet,
                      style: TEXT_BIG,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            );
          }

          final widgetEntities = store.homeWidgetsStream.value;
          final List<Widget> widgets = [
            const SliverPadding(
              padding: EdgeInsets.only(top: 8.0),
            ),
          ];

          for (final we in widgetEntities ?? <HomeWidgetRepr>[]) {
            widgets.add(
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: HORIZONTAL_PADDING - 8.0,
                  vertical: 8.0,
                ),
                sliver: SliverToBoxAdapter(child: we.widget()),
              ),
            );
          }

          widgets.add(
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 8.0),
            ),
          );

          return Scrollbar(
            child: CustomScrollView(
              slivers: widgets,
            ),
          );
        },
      ),
    );
  }
}
