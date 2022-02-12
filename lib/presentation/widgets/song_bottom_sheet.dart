import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/song.dart';
import '../pages/album_details_page.dart';
import '../pages/artist_details_page.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/song_store.dart';
import '../theming.dart';
import '../utils.dart' as utils;
import 'custom_modal_bottom_sheet.dart';
import 'like_button.dart';

class SongBottomSheet extends StatefulWidget {
  const SongBottomSheet({
    Key? key,
    required this.song,
    this.enableGoToAlbum = true,
    this.enableGoToArtist = true,
    this.enableSongCustomization = true,
    this.enableQueueActions = true,
    this.numNavPop = 1,
  }) : super(key: key);

  final Song song;
  final bool enableGoToAlbum;
  final bool enableGoToArtist;
  final bool enableSongCustomization;
  final bool enableQueueActions;
  final int numNavPop;

  @override
  _SongBottomSheetState createState() => _SongBottomSheetState();
}

class _SongBottomSheetState extends State<SongBottomSheet> {
  late SongStore store;

  @override
  void initState() {
    super.initState();

    store = GetIt.I<SongStore>(param1: widget.song);
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    int optionIndex = 0;

    return Observer(builder: (context) {
      final song = store.songStream.value;
      if (song == null) return Container();

      final albums = musicDataStore.albumStream.value;
      final artists = musicDataStore.artistStream.value;

      Artist? artist;
      Album? album;

      if (albums != null && albums.isNotEmpty) {
        album = albums.singleWhere((a) => a.title == song.album);
        if (artists != null && artists.isNotEmpty)
          artist = artists.singleWhere((a) => a.name == album!.artist);
      }

      final options = [
        const SizedBox.shrink(),
        Container(
          color: Colors.white10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SwitchListTile(
                  title: const Text('Previous'),
                  value: song.previous,
                  onChanged: (_) => musicDataStore.togglePreviousSongLink(song),
                  contentPadding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                ),
              ),
              Container(width: 1.0, height: 24.0, color: Colors.white38),
              Expanded(
                child: SwitchListTile(
                  title: const Text('Next'),
                  value: song.next,
                  onChanged: (_) => musicDataStore.toggleNextSongLink(song),
                  contentPadding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white10,
          child: Padding(
            padding: const EdgeInsets.only(
              left: HORIZONTAL_PADDING - 12,
              right: HORIZONTAL_PADDING - 12,
              top: 4.0,
              bottom: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (song.blockLevel != 0) musicDataStore.setSongBlocked(song, 0);
                  },
                  icon: Icon(utils.blockLevelIcon(0)),
                  color: song.blockLevel == 0 ? LIGHT2 : Colors.white38,
                ),
                IconButton(
                  onPressed: () {
                    if (song.blockLevel != 1) musicDataStore.setSongBlocked(song, 1);
                  },
                  icon: Icon(utils.blockLevelIcon(1)),
                  color: song.blockLevel == 1 ? LIGHT2 : Colors.white38,
                ),
                IconButton(
                  onPressed: () {
                    if (song.blockLevel != 2) musicDataStore.setSongBlocked(song, 2);
                  },
                  icon: Icon(utils.blockLevelIcon(2)),
                  color: song.blockLevel == 2 ? LIGHT2 : Colors.white38,
                ),
                IconButton(
                  onPressed: () {
                    if (song.blockLevel != 3) musicDataStore.setSongBlocked(song, 3);
                  },
                  icon: Icon(utils.blockLevelIcon(3)),
                  color: song.blockLevel == 3 ? LIGHT2 : Colors.white38,
                ),
              ],
            ),
          ),
        ),
      ];

      final List<Widget> widgets = [
        Padding(
          padding: const EdgeInsets.all(HORIZONTAL_PADDING),
          child: Row(
            children: [
              Container(
                width: 64.0,
                height: 64.0,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 1)),
                  ],
                  image: DecorationImage(
                    image: utils.getAlbumImage(song.albumArtPath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title,
                      style: TEXT_HEADER_S,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '#${song.trackNumber} • ${utils.msToTimeString(song.duration)} • ${song.year}',
                      style: TEXT_SMALL_SUBTITLE,
                    ),
                    Text(
                      'played: ${song.playCount} • skipped: ${song.skipCount}',
                      style: TEXT_SMALL_SUBTITLE,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        ListTile(
          title: Text('${song.album}'),
          leading: const Icon(Icons.album_rounded),
          trailing: widget.enableGoToAlbum ? const Icon(Icons.open_in_new_rounded) : null,
          visualDensity: VisualDensity.compact,
          onTap: widget.enableGoToAlbum
              ? () {
                  if (album != null) {
                    for (final _ in List.generate(widget.numNavPop, (index) => null))
                      Navigator.pop(context);
                    navStore.pushOnLibrary(
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => AlbumDetailsPage(
                          album: album!,
                        ),
                      ),
                    );
                  }
                }
              : () {},
        ),
        ListTile(
          title: Text(song.artist),
          leading: const Icon(Icons.person_rounded),
          trailing: widget.enableGoToArtist ? const Icon(Icons.open_in_new_rounded) : null,
          visualDensity: VisualDensity.compact,
          onTap: widget.enableGoToArtist
              ? () {
                  if (artist != null) {
                    for (final _ in List.generate(widget.numNavPop, (index) => null))
                      Navigator.pop(context);
                    navStore.pushOnLibrary(
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => ArtistDetailsPage(
                          artist: artist!,
                        ),
                      ),
                    );
                  }
                }
              : () {},
        ),
        if (widget.enableSongCustomization)
          StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: HORIZONTAL_PADDING - 12.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (optionIndex == 1)
                            setState(() => optionIndex = 0);
                          else
                            setState(() => optionIndex = 1);
                        },
                        icon: const Icon(Icons.link),
                        color: utils.linkColor(song),
                      ),
                      LikeButton(song: song),
                      IconButton(
                        onPressed: () {
                          if (optionIndex == 2)
                            setState(() => optionIndex = 0);
                          else
                            setState(() => optionIndex = 2);
                        },
                        icon: Icon(utils.blockLevelIcon(song.blockLevel)),
                        color: utils.blockLevelColor(song.blockLevel),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder: (child, animation) => SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  ),
                  child: options[optionIndex],
                ),
              ],
            ),
          ),
        if (widget.enableQueueActions) ...[
          ListTile(
            title: const Text('Play next'),
            leading: const Icon(Icons.play_arrow_rounded),
            onTap: () {
              audioStore.playNext(song);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          ListTile(
            title: const Text('Append to manually queued songs'),
            leading: const Icon(Icons.play_arrow_rounded),
            onTap: () {},
            enabled: false,
          ),
          ListTile(
            title: const Text('Add to queue'),
            leading: const Icon(Icons.queue_rounded),
            onTap: () {
              audioStore.addToQueue(song);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
        ListTile(
          title: const Text('Add to playlist'),
          leading: const Icon(Icons.playlist_add_rounded),
          onTap: () {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Observer(
                  builder: (context) {
                    final playlists = musicDataStore.playlistsStream.value ?? [];
                    return SimpleDialog(
                      backgroundColor: DARK3,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(HORIZONTAL_PADDING),
                          child: Container(
                            height: 300.0,
                            width: 300.0,
                            child: ListView.separated(
                              itemCount: playlists.length,
                              itemBuilder: (_, int index) {
                                final Playlist playlist = playlists[index];
                                return ListTile(
                                  title: Text(playlist.name),
                                  onTap: () {
                                    musicDataStore.addSongToPlaylist(playlist, song);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => const SizedBox(
                                height: 4.0,
                              ),
                            ),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ];

      return MyBottomSheet(widgets: widgets);
    });
  }
}
