import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/domain/entities/artist.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';
import '../l10n_utils.dart';
import '../state/album_page_store.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/settings_store.dart';
import '../theming.dart';
import '../utils.dart' as utils;
import '../widgets/bottom_sheet/add_to_playlist.dart';
import '../widgets/cover_sliver_appbar.dart';
import '../widgets/custom_modal_bottom_sheet.dart';
import '../widgets/exclude_level_options.dart';
import '../widgets/like_count_options.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile_numbered.dart';
import 'artist_details_page.dart';

class AlbumDetailsPage extends StatefulWidget {
  const AlbumDetailsPage({Key? key, required this.album}) : super(key: key);

  final Album album;

  @override
  _AlbumDetailsPageState createState() => _AlbumDetailsPageState();
}

class _AlbumDetailsPageState extends State<AlbumDetailsPage> {
  late AlbumPageStore store;

  @override
  void initState() {
    super.initState();

    store = GetIt.I<AlbumPageStore>(param1: widget.album);
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();


    return Scaffold(
      body: Material(
        child: Observer(
          builder: (BuildContext context) {
            final album = widget.album;
            final songs = store.albumSongStream.value ?? [];
            final artists = musicDataStore.artistStream.value ?? [];
            final totalDuration =
                songs.fold(const Duration(milliseconds: 0), (Duration d, s) => d + s.duration);
            final songsByDisc = _songsByDisc(store.albumSongStream.value ?? []);
            final discSongNums = [0];
            for (int i = 0; i < songsByDisc.length - 1; i++) {
              discSongNums.add(songsByDisc[i].length + discSongNums[i]);
            }
            Artist? albumArtist;
            if (artists.isNotEmpty)
              albumArtist = artists.singleWhere((a) => a.name == album.artist);

            return Scrollbar(
              child: CustomScrollView(
                slivers: <Widget>[
                  CoverSliverAppBar(
                    title: album.title,
                    subtitle: album.artist,
                    subtitle2:
                        '${album.pubYear.toString()} • ${L10n.of(context)!.nSongs(songs.length)} • ${utils.msToTimeString(totalDuration)}',
                    actions: [
                      Observer(
                        builder: (context) {
                          final isMultiSelectEnabled = store.selection.isMultiSelectEnabled;

                          if (isMultiSelectEnabled)
                            return IconButton(
                              key: GlobalKey(),
                              icon: const Icon(Icons.more_vert_rounded),
                              onPressed: () => _openMultiselectMenu(context),
                            );

                          return Container();
                        },
                      ),
                      Observer(
                        builder: (context) {
                          final isMultiSelectEnabled = store.selection.isMultiSelectEnabled;
                          final isAllSelected = store.selection.isAllSelected;

                          if (isMultiSelectEnabled)
                            return IconButton(
                              key: GlobalKey(),
                              icon: isAllSelected
                                  ? const Icon(Icons.deselect_rounded)
                                  : const Icon(Icons.select_all_rounded),
                              onPressed: () {
                                if (isAllSelected)
                                  store.selection.deselectAll();
                                else
                                  store.selection.selectAll();
                              },
                            );

                          return Container();
                        },
                      ),
                      Observer(builder: (context) {
                        final isMultiSelectEnabled = store.selection.isMultiSelectEnabled;
                        return IconButton(
                          key: const ValueKey('ALBUM_MULTISELECT'),
                          icon: isMultiSelectEnabled
                              ? const Icon(Icons.close_rounded)
                              : const Icon(Icons.checklist_rtl_rounded),
                          onPressed: () => store.selection.toggleMultiSelect(),
                        );
                      })
                    ],
                    cover: Image(
                      image: utils.getAlbumImage(album.albumArtPath),
                      fit: BoxFit.cover,
                    ),
                    onTapTitle: () async {
                      if (albumArtist != null)
                        navStore.pushOnLibrary(
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) =>
                                ArtistDetailsPage(
                              artist: albumArtist!,
                            ),
                          ),
                        );
                    },
                    backgroundColor: utils.bgColor(album.color),
                    button: SizedBox(
                      width: 48,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => audioStore.playAlbum(album),
                          child: const Icon(Icons.play_arrow_rounded),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: LIGHT1,
                            fixedSize: const Size.fromHeight(48),
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  for (int d = 0; d < songsByDisc.length; d++)
                    Observer(
                      builder: (context) {
                        final bool isMultiSelectEnabled = store.selection.isMultiSelectEnabled;
                        final List<bool> isSelected = store.selection.isSelected.toList();

                        return SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              if (songsByDisc.length > 1 && d > 0) Container(height: 8.0),
                              if (songsByDisc.length > 1)
                                ListTile(
                                  title: Text(
                                    '${L10n.of(context)!.disc} ${songsByDisc[d].first.discNumber}',
                                    style: TEXT_HEADER,
                                  ),
                                  leading: const SizedBox(
                                    width: 40,
                                    child: Icon(Icons.album_rounded),
                                  ),
                                  contentPadding: const EdgeInsets.only(left: HORIZONTAL_PADDING),
                                ),
                              if (songsByDisc.length > 1)
                                const Divider(indent: HORIZONTAL_PADDING, endIndent: HORIZONTAL_PADDING),
                              for (int s = 0; s < songsByDisc[d].length; s++)
                                SongListTileNumbered(
                                  song: songsByDisc[d][s],
                                  isSelectEnabled: isMultiSelectEnabled,
                                  isSelected:
                                      isMultiSelectEnabled && isSelected[s + discSongNums[d]],
                                  onTap: () => audioStore.playAlbumFromIndex(
                                    widget.album,
                                    s + _calcOffset(d, songsByDisc),
                                  ),
                                  onTapMore: () => showModalBottomSheet(
                                    context: context,
                                    useRootNavigator: true,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => SongBottomSheet(
                                      song: songsByDisc[d][s],
                                      enableGoToAlbum: false,
                                    ),
                                  ),
                                  onSelect: (bool selected) =>
                                      store.selection.setSelected(selected, s + discSongNums[d]),
                                )
                            ],
                          ),
                        );
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

  List<List<Song>> _songsByDisc(List<Song> songs) {
    final discs = [<Song>[]];
    int currentDisc = 1;

    for (final song in songs) {
      if (song.discNumber == currentDisc) {
        discs.last.add(song);
      } else {
        discs.add([song]);
        currentDisc = song.discNumber;
      }
    }

    return discs;
  }

  int _calcOffset(int disc, List<List> discs) {
    int offset = 0;
    for (int i = 0; i < disc; i++) {
      offset += discs[i].length;
    }
    return offset;
  }

  Future<void> _openMultiselectMenu(BuildContext context) async {
    final audioStore = GetIt.I<AudioStore>();
    final musicDataStore = GetIt.I<MusicDataStore>();
    final settingsStore = GetIt.I<SettingsStore>();

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Observer(builder: (context) {
        final isSelected = store.selection.isSelected;
        final allSongs = store.albumSongStream.value ?? [];
        final songs = <Song>[];
        for (int i = 0; i < allSongs.length; i++) {
          if (isSelected[i]) songs.add(allSongs[i]);
        }

        return MyBottomSheet(
          widgets: [
            ListTile(
              title: Text(L10n.of(context)!.nSongsSelected(songs.length).capitalize()),
            ),
            LikeCountOptions(songs: songs, musicDataStore: musicDataStore),
            Container(
              height: 1,
              color: Colors.transparent,
            ),
            ExcludeLevelOptions(songs: songs, musicDataStore: musicDataStore),
            ListTile(
              title: Text(L10n.of(context)!.playNext),
              leading: const Icon(Icons.play_arrow_rounded),
              onTap: () {
                audioStore.playNext(songs);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            ListTile(
              title: Text(L10n.of(context)!.appendToQueued),
              leading: const Icon(Icons.play_arrow_rounded),
              onTap: () {
                audioStore.appendToNext(songs);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            ListTile(
              title: Text(L10n.of(context)!.addToQueue),
              leading: const Icon(Icons.queue_rounded),
              onTap: () {
                audioStore.addToQueue(songs);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            AddToPlaylistTile(songs: songs, musicDataStore: musicDataStore),
            ListTile(
              title: Text(L10n.of(context)!.blockFromLibrary),
              leading: const Icon(Icons.block),
              onTap: () {
                settingsStore.addBlockedFiles(songs.map((e) => e.path).toList());
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      }),
    );
  }
}
