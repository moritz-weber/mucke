import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';

import '../home_widgets/album_of_day_repr.dart';
import '../home_widgets/artist_of_day_repr.dart';
import '../home_widgets/history_repr.dart';
import '../home_widgets/home_widget_repr.dart';
import '../home_widgets/playlists_repr.dart';
import '../home_widgets/shuffle_all_repr.dart';
import '../state/home_page_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../widgets/custom_modal_bottom_sheet.dart';

class HomeSettingsPage extends StatelessWidget {
  const HomeSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeStore = GetIt.I<HomePageStore>();
    final navStore = GetIt.I<NavigationStore>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            L10n.of(context)!.homeCustomization,
            style: TEXT_HEADER,
          ),
          centerTitle: true,
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
            final widgetReprs = homeStore.homeWidgetsStream.value ?? <HomeWidgetRepr>[];

            return Scrollbar(
              child: CustomScrollView(
                slivers: [
                  ReorderableSliverList(
                    delegate: ReorderableSliverChildBuilderDelegate(
                      (context, int index) {
                        return Dismissible(
                          key: UniqueKey(),
                          child: ListTile(
                            title: Text(widgetReprs[index].title(context)),
                            leading: Icon(widgetReprs[index].icon),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widgetReprs[index].hasParameters)
                                  IconButton(
                                    onPressed: () {
                                      navStore.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => widgetReprs[index].formPage()!,
                                        ),
                                      );
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
                            homeStore.removeHomeWidget(widgetReprs[index].homeWidgetEntity);
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
                      childCount: widgetReprs.length,
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
    final homeWidgets = homeStore.homeWidgetsStream.value ?? <HomeWidgetRepr>[];

    final homeWidgetReprs = [
      ShuffleAllRepr.fromPosition(homeWidgets.length),
      AlbumOfDayRepr.fromPosition(homeWidgets.length),
      ArtistOfDayRepr.fromPosition(homeWidgets.length),
      HistoryRepr.fromPosition(homeWidgets.length),
      PlaylistsRepr.fromPosition(homeWidgets.length),
    ];

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Observer(builder: (context) {
        return MyBottomSheet(
          widgets: [
            ListTile(
              title: Text(
                L10n.of(context)!.addWidgetToHome,
                style: TEXT_HEADER_S,
              ),
              tileColor: DARK2,
            ),
            for (final homeWidgetRepr in homeWidgetReprs)
              ListTile(
                title: Text(homeWidgetRepr.title(context)),
                leading: Icon(homeWidgetRepr.icon),
                onTap: () {
                  homeStore.addHomeWidget(homeWidgetRepr.homeWidgetEntity);
                  Navigator.of(context).pop();
                },
              ),
          ],
        );
      }),
    );
  }
}
