import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/smart_list.dart';
import '../pages/smart_list_page.dart';
import '../state/navigation_store.dart';
import '../state/settings_store.dart';

class SmartLists extends StatelessWidget {
  const SmartLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();

    return Observer(
      builder: (context) {
        final smartLists = settingsStore.smartListsStream.value ?? [];
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, int index) {
              final SmartList smartList = smartLists[index];
              return ListTile(
                title: Text(smartList.name),
                onTap: () => navStore.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (context) => SmartListPage(smartList: smartList),
                  ),
                ),
              );
            },
            childCount: smartLists.length,
          ),
        );
      },
    );
  }
}
