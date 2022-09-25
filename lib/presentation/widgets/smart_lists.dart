import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/custom_list.dart';
import '../../domain/entities/home_widgets/playlists.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/smart_list.dart';
import '../pages/playlist_page.dart';
import '../pages/smart_list_page.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import 'play_shuffle_button.dart';
import 'playlist_cover.dart';

class SmartLists extends StatelessWidget {
  const SmartLists({Key? key, required this.homePlaylists}) : super(key: key);

  final HomePlaylists homePlaylists;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();

    final customListsStream = musicDataStore.getCustomLists(
      orderCriterion: homePlaylists.orderCriterion,
      orderDirection: homePlaylists.orderDirection,
      filter: homePlaylists.filter,
      limit: homePlaylists.maxEntries,
    );

    return Observer(
      builder: (context) {
        final customLists = customListsStream.value ?? [];

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, int index) {
              if (index % 2 == 1) {
                return const SizedBox(height: 12.0);
              }

              final CustomList customList = customLists[index ~/ 2];
              return GestureDetector(
                onTap: () {
                  if (customList is SmartList)
                    navStore.pushOnLibrary(
                      MaterialPageRoute<Widget>(
                        builder: (context) => SmartListPage(smartList: customList),
                      ),
                    );
                  else if (customList is Playlist)
                    navStore.pushOnLibrary(
                      MaterialPageRoute<Widget>(
                        builder: (context) => PlaylistPage(playlist: customList),
                      ),
                    );
                },
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
                            gradient: customList.gradient,
                            icon: customList.icon,
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
                              customList.name,
                              style: Theme.of(context).textTheme.headline4,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          PlayShuffleButton(
                            onPressed: () {
                              if (customList is SmartList)
                                audioStore.playSmartList(customList);
                              else if (customList is Playlist) audioStore.playPlaylist(customList);
                            },
                            shuffleMode: customList.shuffleMode,
                            size: 48.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: customLists.length * 2 - 1,
          ),
        );
      },
    );
  }
}
