import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';

import '../../domain/entities/playlist.dart';
import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../theming.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({Key? key, required this.playlist}) : super(key: key);

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();

    return SafeArea(
      child: StreamBuilder<Playlist>(
          stream: musicDataStore.getPlaylistStream(playlist.id),
          builder: (context, snapshot) {
            final Playlist uPlaylist = snapshot.data ?? playlist;

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  uPlaylist.name,
                  style: TEXT_HEADER,
                ),
                leading: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editPlaylist(context, uPlaylist)),
                ],
                titleSpacing: 0.0,
              ),
              body: Scrollbar(
                child: CustomScrollView(
                  slivers: [
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
                              onTap: () => audioStore.playSong(index, uPlaylist.songs),
                              onTapMore: () => SongBottomSheet()(song, context),
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
                musicDataStore.updatePlaylist(widget.playlist.id, _controller.text);
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
