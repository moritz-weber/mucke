import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/home_widgets/artist_of_day.dart';
import '../../domain/entities/home_widgets/history.dart';
import '../../domain/entities/home_widgets/home_widget.dart';
import '../../domain/entities/home_widgets/playlists.dart';
import '../../domain/entities/home_widgets/shuffle_all.dart';
import '../state/home_page_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../widgets/highlight_album.dart';
import '../widgets/highlight_artist.dart';
import '../widgets/history_widget.dart';
import '../widgets/playlists_widget.dart';
import '../widgets/shuffle_all_button.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              tooltip: 'Customize Home Page',
              onPressed: () => navStore.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeSettingsPage()),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings_rounded),
              tooltip: 'Settings',
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
                    children: const [
                      Icon(Icons.music_note_rounded, size: 64.0),
                      SizedBox(height: 24.0),
                      Text(
                        "Looks like you don't have any songs in your library: Go to settings, add your music folders, and update your library.",
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

            for (final HomeWidget we in widgetEntities ?? <HomeWidget>[]) {
              widgets.add(
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: HORIZONTAL_PADDING - 8.0, vertical: 8.0),
                  sliver: _createHomeWidget(we),
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
      ),
    );
  }
}

Widget _createHomeWidget(HomeWidget homeWidget) {
  switch (homeWidget.type) {
    case HomeWidgetType.shuffle_all:
      return SliverToBoxAdapter(
        child: ShuffleAllButton(
          shuffleMode: (homeWidget as HomeShuffleAll).shuffleMode,
        ),
      );
    case HomeWidgetType.album_of_day:
      return const SliverToBoxAdapter(
        child: HighlightAlbum(),
      );
    case HomeWidgetType.artist_of_day:
      return SliverToBoxAdapter(
        child: HighlightArtist(
          shuffleMode: (homeWidget as HomeArtistOfDay).shuffleMode,
        ),
      );
    case HomeWidgetType.playlists:
      return SliverToBoxAdapter(
        child: PlaylistsWidget(homePlaylists: homeWidget as HomePlaylists),
      );
    case HomeWidgetType.history:
      return SliverToBoxAdapter(
        child: HistoryWidget(history: homeWidget as HomeHistory),
      );
  }
}
