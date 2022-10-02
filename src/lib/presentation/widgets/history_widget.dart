import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/home_widgets/history.dart';
import '../../domain/entities/playable.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/smart_list.dart';
import '../pages/album_details_page.dart';
import '../pages/artist_details_page.dart';
import '../pages/playlist_page.dart';
import '../pages/smart_list_page.dart';
import '../state/audio_store.dart';
import '../state/history_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../utils.dart';
import 'play_shuffle_button.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({Key? key, required this.history}) : super(key: key);

  final HomeHistory history;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final HistoryStore historyStore = GetIt.I<HistoryStore>();

    final historyStream = historyStore.getHistoryStream(history.maxEntries);

    return Observer(
      builder: (context) {
        final historyEntries = historyStream.value ?? [];

        return Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 16.0),
                  child: Text(
                    'Last Played',
                    style: TEXT_BIG,
                  ),
                ),
                ...historyEntries.map(
                  (historyEntry) {
                    final shuffleMode = historyEntry.playable.getShuffleMode();
                    return ListTile(
                      leading: createPlayableCover(historyEntry.playable, 56.0),
                      title: Text(
                        historyEntry.playable.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(historyEntry.playable.type.toText()),
                      trailing: PlayShuffleButton(
                        onPressed: () {
                          audioStore.playPlayable(historyEntry.playable, shuffleMode);
                        },
                        shuffleMode: shuffleMode,
                        size: 48.0,
                      ),
                      contentPadding: const EdgeInsets.only(left: 12.0, right: 8.0),
                      onTap: () {
                        Widget page = Container();
                        switch (historyEntry.playable.type) {
                          case PlayableType.album:
                            page = AlbumDetailsPage(album: historyEntry.playable as Album);
                            break;
                          case PlayableType.artist:
                            page = ArtistDetailsPage(artist: historyEntry.playable as Artist);
                            break;
                          case PlayableType.playlist:
                            page = PlaylistPage(playlist: historyEntry.playable as Playlist);
                            break;
                          case PlayableType.smartlist:
                            page = SmartListPage(smartList: historyEntry.playable as SmartList);
                            break;
                          default:
                        }

                        navStore.pushOnLibrary(
                          MaterialPageRoute<Widget>(
                            builder: (context) => page,
                          ),
                        );
                      },
                    );
                  },
                ),
                if (historyEntries.isEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                    child: Text(
                      'Nothing to see here yet. Play something.',
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
