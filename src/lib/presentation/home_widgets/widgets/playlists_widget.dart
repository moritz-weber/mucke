import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/home_widgets/playlists.dart';
import '../../../domain/entities/playlist.dart';
import '../../../domain/entities/smart_list.dart';
import '../../pages/playlist_page.dart';
import '../../pages/smart_list_page.dart';
import '../../state/audio_store.dart';
import '../../state/music_data_store.dart';
import '../../state/navigation_store.dart';
import '../../theming.dart';
import '../../widgets/play_shuffle_button.dart';
import '../../widgets/playlist_cover.dart';

class PlaylistsWidget extends StatelessWidget {
  const PlaylistsWidget({Key? key, required this.homePlaylists}) : super(key: key);

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

        return Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 16.0),
                  child: Text(
                    homePlaylists.title,
                    style: TEXT_BIG,
                  ),
                ),
                ...customLists.map(
                  (customList) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 12.0, right: 8.0),
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
                        leading: PlaylistCover(
                          size: 56.0,
                          gradient: customList.gradient,
                          icon: customList.icon,
                        ),
                        title: Text(
                          customList.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: PlayShuffleButton(
                          onPressed: () {
                            if (customList is SmartList)
                              audioStore.playSmartList(customList);
                            else if (customList is Playlist) audioStore.playPlaylist(customList);
                          },
                          shuffleMode: customList.shuffleMode,
                          size: 48.0,
                        ),
                      ),
                    );
                  },
                ),
                if (customLists.isEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                    child: Text(
                      L10n.of(context)!.noPlaylistsYet,
                      style: TEXT_HEADER_S.copyWith(color: Colors.white54),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
