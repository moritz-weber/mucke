import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/home_widgets/artist_of_day.dart';
import '../../domain/entities/home_widgets/home_widget.dart';
import '../../domain/entities/home_widgets/shuffle_all.dart';
import '../state/home_page_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../widgets/highlight_album.dart';
import '../widgets/highlight_artist.dart';
import '../widgets/shuffle_all_button.dart';
import '../widgets/smart_lists.dart';
import 'home_settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final store = GetIt.I<HomePageStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

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
              onPressed: () => navStore.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeSettingsPage()),
              ),
            ),
          ],
        ),
        body: Observer(
          builder: (context) {
            final widgetEntities = store.homeWidgetsStream.value;
            final List<Widget> widgets = [
              const SliverPadding(
                padding: EdgeInsets.only(top: 8.0),
              ),
            ];

            for (final HomeWidget we in widgetEntities ?? <HomeWidget>[]) {
              widgets.add(
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING, vertical: 8.0),
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
      return const SmartLists();
  }
}
