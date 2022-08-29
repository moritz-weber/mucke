import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/smart_list.dart';
import '../pages/smart_list_page.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import 'play_shuffle_button.dart';
import 'playlist_cover.dart';

class SmartLists extends StatelessWidget {
  const SmartLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();

    return Observer(
      builder: (context) {
        final smartLists = musicDataStore.smartListsStream.value ?? [];
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).cardColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 8,
                          offset: Offset(0, 1),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PlaylistCover(
                              size: 48,
                              gradient: smartList.gradient,
                              icon: smartList.icon,
                              shadows: const [
                                BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                    spreadRadius: -1),
                              ],
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                smartList.name,
                                style: Theme.of(context).textTheme.headline4,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            PlayShuffleButton(
                              onPressed: () => audioStore.playSmartList(smartList),
                              shuffleMode: smartList.shuffleMode,
                              size: 48.0,
                            ),
                          ],
                        ),
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
