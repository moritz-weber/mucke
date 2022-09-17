import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';

import '../../domain/entities/home_widgets/album_of_day.dart';
import '../../domain/entities/home_widgets/artist_of_day.dart';
import '../../domain/entities/home_widgets/home_widget.dart';
import '../../domain/entities/home_widgets/playlists.dart';
import '../../domain/entities/home_widgets/shuffle_all.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../state/home_page_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../widgets/custom_modal_bottom_sheet.dart';

class HomeSettingsPage extends StatelessWidget {
  const HomeSettingsPage({Key? key}) : super(key: key);

  static const titles = {
    HomeWidgetType.album_of_day: 'Album of the Day',
    HomeWidgetType.artist_of_day: 'Artist of the Day',
    HomeWidgetType.playlists: 'Playlists',
    HomeWidgetType.shuffle_all: 'Shuffle All',
  };

  static const icons = {
    HomeWidgetType.album_of_day: Icons.album_rounded,
    HomeWidgetType.artist_of_day: Icons.person_rounded,
    HomeWidgetType.playlists: Icons.playlist_play_rounded,
    HomeWidgetType.shuffle_all: Icons.shuffle_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final homeStore = GetIt.I<HomePageStore>();
    final navStore = GetIt.I<NavigationStore>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home Customization',
            style: TEXT_HEADER,
          ),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: () => navStore.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_rounded),
              onPressed: () => _onTapAdd(context),
            ),
          ],
        ),
        body: Observer(
          builder: (context) {
            final widgetEntities = homeStore.homeWidgetsStream.value ?? <HomeWidget>[];
            final List<Widget> widgets = [
              const SliverPadding(
                padding: EdgeInsets.only(top: 8.0),
              ),
            ];

            widgets.add(
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 8.0),
              ),
            );

            return Scrollbar(
              child: CustomScrollView(
                slivers: [
                  ReorderableSliverList(
                    delegate: ReorderableSliverChildBuilderDelegate(
                      (context, int index) {
                        return ListTile(
                          title: Text(titles[widgetEntities[index].type]!),
                          leading: Icon(icons[widgetEntities[index].type]),
                          trailing: IconButton(
                            onPressed: () => _onTapMore(context, widgetEntities[index]),
                            icon: const Icon(Icons.more_vert_rounded),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            HORIZONTAL_PADDING,
                            8.0,
                            0.0,
                            8.0,
                          ),
                        );
                      },
                      childCount: widgetEntities.length,
                    ),
                    onReorder: (oldIndex, newIndex) {
                      homeStore.moveHomeWidget(oldIndex, newIndex);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _onTapAdd(BuildContext context) async {
    final homeStore = GetIt.I<HomePageStore>();
    final homeWidgets = homeStore.homeWidgetsStream.value ?? <HomeWidget>[];

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Observer(builder: (context) {
        return MyBottomSheet(
          widgets: [
            const ListTile(
              title: Text(
                'Add a Widget to Your Home Page',
                style: TEXT_HEADER_S,
              ),
              tileColor: DARK2,
            ),
            for (final type in HomeWidgetType.values)
              ListTile(
                title: Text(titles[type]!),
                leading: Icon(icons[type]),
                onTap: () {
                  homeStore.addHomeWidget(
                    _createHomeWidget(type, homeWidgets.length),
                  );
                  Navigator.of(context).pop();
                },
              ),
          ],
        );
      }),
    );
  }

  Future<void> _onTapMore(BuildContext context, HomeWidget homeWidget) async {
    final homeStore = GetIt.I<HomePageStore>();

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Observer(builder: (context) {
        return MyBottomSheet(
          widgets: [
            ListTile(
              title: Text(titles[homeWidget.type]!),
              subtitle: Text(
                'Position: ${homeWidget.position + 1}',
                style: TEXT_SMALL_SUBTITLE,
              ),
              leading: Icon(icons[homeWidget.type]),
              tileColor: DARK2,
            ),
            ListTile(
              title: const Text('Remove widget'),
              leading: const Icon(
                Icons.delete_forever_rounded,
                color: RED,
              ),
              onTap: () {
                homeStore.removeHomeWidget(homeWidget);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }),
    );
  }

  // TODO: replace this with opening a custom bottom sheet for components with parameters
  HomeWidget _createHomeWidget(HomeWidgetType type, int position) {
    switch (type) {
      case HomeWidgetType.shuffle_all:
        return HomeShuffleAll(position, ShuffleMode.plus);
      case HomeWidgetType.album_of_day:
        return HomeAlbumOfDay(position);
      case HomeWidgetType.artist_of_day:
        return HomeArtistOfDay(position, ShuffleMode.plus);
      case HomeWidgetType.playlists:
        return HomePlaylists(position);
    }
  }
}
