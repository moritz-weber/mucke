import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';
import '../state/album_page_store.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../theming.dart';
import '../widgets/album_sliver_appbar.dart';
import '../widgets/bottom_sheet/add_to_playlist.dart';
import '../widgets/custom_modal_bottom_sheet.dart';
import '../widgets/exclude_level_options.dart';
import '../widgets/like_count_options.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile_numbered.dart';

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

    return Scaffold(
      body: Observer(
        builder: (BuildContext context) {
          final songsByDisc = _songsByDisc(store.albumSongStream.value ?? []);
          final discSongNums = [0];
          for (int i = 0; i < songsByDisc.length - 1; i++) {
            discSongNums.add(songsByDisc[i].length + discSongNums[i]);
          }

          return CustomScrollView(
            slivers: <Widget>[
              AlbumSliverAppBar(
                album: widget.album,
                store: store,
                onTapMultiSelectMenu: () => _openMultiselectMenu(context),
              ),
              for (int d = 0; d < songsByDisc.length; d++)
                Observer(builder: (context) {
                  final bool isMultiSelectEnabled = store.isMultiSelectEnabled;
                  final List<bool> isSelected = store.isSelected.toList();

                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        if (songsByDisc.length > 1 && d > 0) Container(height: 8.0),
                        if (songsByDisc.length > 1)
                          ListTile(
                            title: Text('Disc ${d + 1}', style: TEXT_HEADER),
                            leading: const SizedBox(width: 40, child: Icon(Icons.album)),
                            contentPadding: const EdgeInsets.only(left: HORIZONTAL_PADDING),
                          ),
                        if (songsByDisc.length > 1)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: HORIZONTAL_PADDING,
                            ),
                            child: Container(
                              height: 1.0,
                              color: Colors.white10,
                            ),
                          ),
                        for (int s = 0; s < songsByDisc[d].length; s++)
                          SongListTileNumbered(
                            song: songsByDisc[d][s],
                            isSelectEnabled: isMultiSelectEnabled,
                            isSelected: isMultiSelectEnabled && isSelected[s + discSongNums[d]],
                            onTap: () => audioStore.playSong(
                              s + _calcOffset(d, songsByDisc),
                              store.albumSongStream.value!,
                              widget.album,
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
                                store.setSelected(selected, s + discSongNums[d]),
                          )
                      ],
                    ),
                  );
                })
            ],
          );
        },
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

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Observer(builder: (context) {
        final isSelected = store.isSelected;
        final allSongs = store.albumSongStream.value ?? [];
        final songs = <Song>[];
        for (int i = 0; i < allSongs.length; i++) {
          if (isSelected[i]) songs.add(allSongs[i]);
        }

        return MyBottomSheet(
          widgets: [
            ListTile(
              title: Text('${songs.length} songs selected'),
            ),
            LikeCountOptions(songs: songs, musicDataStore: musicDataStore),
            Container(
              height: 1,
              color: Colors.transparent,
            ),
            ExcludeLevelOptions(songs: songs, musicDataStore: musicDataStore),
            ListTile(
              title: const Text('Play next'),
              leading: const Icon(Icons.play_arrow_rounded),
              onTap: () {
                audioStore.playNext(songs);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            ListTile(
              title: const Text('Append to manually queued songs'),
              leading: const Icon(Icons.play_arrow_rounded),
              onTap: () {
                audioStore.appendToNext(songs);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            ListTile(
              title: const Text('Add to queue'),
              leading: const Icon(Icons.queue_rounded),
              onTap: () {
                audioStore.addToQueue(songs);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            AddToPlaylistTile(songs: songs, musicDataStore: musicDataStore),
          ],
        );
      }),
    );
  }
}
