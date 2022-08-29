import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';

import '../../domain/entities/playlist.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/song.dart';
import '../mucke_icons.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../utils.dart' as utils;
import '../widgets/cover_sliver_appbar.dart';
import '../widgets/playlist_cover.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';
import 'playlist_form_page.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({Key? key, required this.playlist}) : super(key: key);

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return SafeArea(
      child: StreamBuilder<Playlist>(
          stream: musicDataStore.getPlaylistStream(playlist.id),
          builder: (context, snapshot) {
            final Playlist uPlaylist = snapshot.data ?? playlist; // *u* for updating

            final totalDuration = playlist.songs.fold(
              const Duration(milliseconds: 0),
              (Duration d, s) => d + s.duration,
            );

            IconData playIcon = Icons.play_arrow_rounded;
            switch (playlist.shuffleMode) {
              case ShuffleMode.standard:
                playIcon = Icons.shuffle_rounded;
                break;
              case ShuffleMode.plus:
                playIcon = MuckeIcons.shuffle_heart;
                break;
              case ShuffleMode.none:
                playIcon = MuckeIcons.shuffle_none;
                break;
              default:
            }

            return Scaffold(
              body: Scrollbar(
                child: CustomScrollView(
                  slivers: [
                    CoverSliverAppBar(
                      actions: [
                        Observer(
                          builder: (context) {
                            final isMultiSelectEnabled =
                                false; // store.selection.isMultiSelectEnabled;

                            if (!isMultiSelectEnabled)
                              return IconButton(
                                key: GlobalKey(),
                                icon: const Icon(Icons.edit_rounded),
                                onPressed: () => navStore.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => PlaylistFormPage(
                                      playlist: playlist,
                                    ),
                                  ),
                                ),
                              );

                            return Container();
                          },
                        ),
                        // Observer(
                        //   builder: (context) {
                        //     final isMultiSelectEnabled = false; // store.selection.isMultiSelectEnabled;

                        //     if (isMultiSelectEnabled)
                        //       return IconButton(
                        //         key: GlobalKey(),
                        //         icon: const Icon(Icons.more_vert_rounded),
                        //         onPressed: () => _openMultiselectMenu(context),
                        //       );

                        //     return Container();
                        //   },
                        // ),
                        // Observer(
                        //   builder: (context) {
                        //     final isMultiSelectEnabled = store.selection.isMultiSelectEnabled;
                        //     final isAllSelected = store.selection.isAllSelected;

                        //     if (isMultiSelectEnabled)
                        //       return IconButton(
                        //         key: GlobalKey(),
                        //         icon: isAllSelected
                        //             ? const Icon(Icons.deselect_rounded)
                        //             : const Icon(Icons.select_all_rounded),
                        //         onPressed: () {
                        //           if (isAllSelected)
                        //             store.selection.deselectAll();
                        //           else
                        //             store.selection.selectAll();
                        //         },
                        //       );

                        //     return Container();
                        //   },
                        // ),
                        // Observer(
                        //   builder: (context) {
                        //     final isMultiSelectEnabled = store.selection.isMultiSelectEnabled;
                        //     return IconButton(
                        //       key: const ValueKey('SMARTLIST_MULTISELECT'),
                        //       icon: isMultiSelectEnabled
                        //           ? const Icon(Icons.close_rounded)
                        //           : const Icon(Icons.checklist_rtl_rounded),
                        //       onPressed: () => store.selection.toggleMultiSelect(),
                        //     );
                        //   },
                        // ),
                      ],
                      title: playlist.name,
                      subtitle2:
                          '${playlist.songs.length} songs • ${utils.msToTimeString(totalDuration)}',
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: playlist.gradient,
                        ),
                      ),
                      cover: PlaylistCover(
                        size: 120,
                        icon: playlist.icon,
                        gradient: playlist.gradient,
                      ),
                      button: ElevatedButton(
                        onPressed: () => audioStore.playPlaylist(playlist),
                        child: Row(
                          children: [
                            const Expanded(child: Center(child: Text('Play'))),
                            Icon(playIcon),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          primary: Colors.white10,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                    ),
                    ReorderableSliverList(
                      delegate: ReorderableSliverChildBuilderDelegate(
                        (context, int index) {
                          final Song song = uPlaylist.songs[index];
                          return Dismissible(
                            key: ValueKey(song.path),
                            child: SongListTile(
                              song: song,
                              showAlbum: true,
                              subtitle: Subtitle.artistAlbum,
                              onTap: () => audioStore.playSong(index, uPlaylist.songs, uPlaylist),
                              onTapMore: () => showModalBottomSheet(
                                context: context,
                                useRootNavigator: true,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => SongBottomSheet(
                                  song: song,
                                ),
                              ),
                              onSelect: () {},
                            ),
                            onDismissed: (direction) {
                              musicDataStore.removePlaylistEntry(uPlaylist.id, index);
                            },
                          );
                        },
                        childCount: uPlaylist.songs.length,
                      ),
                      onReorder: (oldIndex, newIndex) =>
                          musicDataStore.movePlaylistEntry(uPlaylist.id, oldIndex, newIndex),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _editPlaylist(BuildContext context, Playlist playlist) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _PlaylistForm(playlist: playlist);
      },
    ).then((value) {
      if (value != null && value as bool) {
        Navigator.pop(context);
      }
    });
  }
}

class _PlaylistForm extends StatefulWidget {
  const _PlaylistForm({Key? key, required this.playlist}) : super(key: key);

  final Playlist playlist;

  @override
  _PlaylistFormState createState() => _PlaylistFormState();
}

class _PlaylistFormState extends State<_PlaylistForm> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.playlist.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();

    return SimpleDialog(
      backgroundColor: DARK3,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(HORIZONTAL_PADDING),
          child: TextField(
            controller: _controller,
          ),
        ),
        Row(
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                textAlign: TextAlign.center,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                musicDataStore.removePlaylist(widget.playlist);
                Navigator.pop(context, true);
              },
              child: const Text(
                'Delete',
                textAlign: TextAlign.center,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                // musicDataStore.updatePlaylist(widget.playlist.id, _controller.text);
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
