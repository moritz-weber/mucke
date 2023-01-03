import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/song.dart';
import '../pages/album_details_page.dart';
import '../pages/artist_details_page.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/settings_store.dart';
import '../state/song_store.dart';
import '../theming.dart';
import '../utils.dart' as utils;
import 'bottom_sheet/add_to_playlist.dart';
import 'custom_modal_bottom_sheet.dart';
import 'exclude_level_options.dart';
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
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();

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
          // color: DARK3,
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
              Container(width: 1.0, height: 24.0, color: DARK2),
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
        ExcludeLevelOptions(songs: [song], musicDataStore: musicDataStore),
      ];

      final List<Widget> widgets = [
        Container(
          color: DARK2,
          child: Padding(
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
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 1),
                      ),
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
                        icon: const Icon(Icons.link_rounded),
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
              audioStore.playNext([song]);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          ListTile(
            title: const Text('Append to manually queued songs'),
            leading: const Icon(Icons.play_arrow_rounded),
            onTap: () {
              audioStore.appendToNext([song]);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          ListTile(
            title: const Text('Add to queue'),
            leading: const Icon(Icons.queue_rounded),
            onTap: () {
              audioStore.addToQueue([song]);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
        AddToPlaylistTile(songs: [song], musicDataStore: musicDataStore),
        ListTile(
          title: const Text('Block from library'),
            leading: const Icon(Icons.block),
            onTap: () {
              settingsStore.addBlockedFiles([song.path]);
              Navigator.of(context, rootNavigator: true).pop();
            },
        ),
      ];

      return MyBottomSheet(widgets: widgets);
    });
  }
}
