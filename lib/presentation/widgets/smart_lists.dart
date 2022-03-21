import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/smart_list.dart';
import '../pages/smart_list_page.dart';
import '../state/audio_store.dart';
import '../state/navigation_store.dart';
import '../state/settings_store.dart';
import '../theming.dart';

class SmartLists extends StatelessWidget {
  const SmartLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();

    return Observer(
      builder: (context) {
        final smartLists = settingsStore.smartListsStream.value ?? [];
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, int index) {
              final SmartList smartList = smartLists[index];
              return GestureDetector(
                onTap: () => navStore.pushOnLibrary(
                  MaterialPageRoute<Widget>(
                    builder: (context) => SmartListPage(smartList: smartList),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: HORIZONTAL_PADDING,
                    vertical: 6.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: Colors.white10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: HORIZONTAL_PADDING, top: 4.0, bottom: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              smartList.name,
                              style: Theme.of(context).textTheme.headline4,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.play_circle_fill_rounded,
                              size: 40.0,
                            ),
                            iconSize: 48.0,
                            onPressed: () => audioStore.playSmartList(smartList),
                          ),
                        ],
                      ),
                    ),
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
