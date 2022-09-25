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
import 'home_widget_forms/artistofday_form_page.dart';
import 'home_widget_forms/playlists_form_page.dart';
import 'home_widget_forms/shuffle_all_form_page.dart';

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

  static const hasParameters = {
    HomeWidgetType.album_of_day: false,
    HomeWidgetType.artist_of_day: true,
    HomeWidgetType.playlists: true,
    HomeWidgetType.shuffle_all: true,
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

            return Scrollbar(
              child: CustomScrollView(
                slivers: [
                  ReorderableSliverList(
                    delegate: ReorderableSliverChildBuilderDelegate(
                      (context, int index) {
                        return Dismissible(
                          key: UniqueKey(),
                          child: ListTile(
                            title: Text(titles[widgetEntities[index].type]!),
                            leading: Icon(icons[widgetEntities[index].type]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (hasParameters[widgetEntities[index].type]!)
                                  IconButton(
                                    onPressed: () {
                                      switch (widgetEntities[index].type) {
                                        case HomeWidgetType.shuffle_all:
                                          navStore.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ShuffleAllFormPage(
                                                shuffleAll: widgetEntities[index] as HomeShuffleAll,
                                              ),
                                            ),
                                          );
                                          break;
                                        case HomeWidgetType.artist_of_day:
                                          navStore.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ArtistOfDayFormPage(
                                                artistOfDay:
                                                    widgetEntities[index] as HomeArtistOfDay,
                                              ),
                                            ),
                                          );
                                          break;
                                        case HomeWidgetType.playlists:
                                          navStore.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PlaylistsFormPage(
                                                playlists: widgetEntities[index] as HomePlaylists,
                                              ),
                                            ),
                                          );
                                          break;
                                        default:
                                          break;
                                      }
                                    },
                                    icon: const Icon(Icons.edit_rounded),
                                  ),
                              ],
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                              HORIZONTAL_PADDING,
                              8.0,
                              0.0,
                              8.0,
                            ),
                          ),
                          onDismissed: (direction) {
                            homeStore.removeHomeWidget(widgetEntities[index]);
                          },
                          background: Container(
                            width: double.infinity,
                            color: RED,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(
                                    Icons.delete_forever_rounded,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.delete_forever_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
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

  HomeWidget _createHomeWidget(HomeWidgetType type, int position) {
    switch (type) {
      case HomeWidgetType.shuffle_all:
        return HomeShuffleAll(position: position, shuffleMode: ShuffleMode.plus);
      case HomeWidgetType.album_of_day:
        return HomeAlbumOfDay(position);
      case HomeWidgetType.artist_of_day:
        return HomeArtistOfDay(position: position, shuffleMode: ShuffleMode.plus);
      case HomeWidgetType.playlists:
        return HomePlaylists(position: position);
    }
  }
}
