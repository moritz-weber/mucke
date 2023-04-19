import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/song.dart';
import '../l10n_utils.dart';
import '../mucke_icons.dart';
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

    return Observer(builder: (context) {
      final song = store.songStream.value;
      if (song == null) return Container();
      final firstLast = musicDataStore.isSongFirstLast(song);

      final albums = musicDataStore.albumStream.value;
      final artists = musicDataStore.artistStream.value;

      Artist? artist;
      Album? album;

      if (albums != null && albums.isNotEmpty) {
        album = albums.singleWhere((a) => a.id == song.albumId);
        if (artists != null && artists.isNotEmpty)
          artist = artists.singleWhere((a) => a.name == album!.artist);
      }

      final List<Widget> widgets = [
        Container(
          color: DARK2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              HORIZONTAL_PADDING,
              HORIZONTAL_PADDING,
              HORIZONTAL_PADDING - 12.0,
              HORIZONTAL_PADDING,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 2.0),
                      Text(
                        '#${song.trackNumber} • ${utils.msToTimeString(song.duration)} • ${song.year}',
                        style: TEXT_SMALL_SUBTITLE,
                      ),
                      Text(
                        L10n.of(context)!.playedNTimes(song.playCount).capitalize(),
                        style: TEXT_SMALL_SUBTITLE.copyWith(height: 1.2),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 64.0,
                  child: Center(
                    child: LikeButton(
                      song: song,
                      iconSize: 28.0,
                      visualDensity: VisualDensity.standard,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: Text('${song.album}'),
          leading: const Icon(Icons.album_rounded),
          trailing: widget.enableGoToAlbum ? const Icon(Icons.open_in_new_rounded) : null,
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
          ExcludeLevelOptions(songs: [song], musicDataStore: musicDataStore),
        if (widget.enableSongCustomization)
          FutureBuilder(
              future: firstLast,
              builder: (context, AsyncSnapshot<List<bool>> snapshot) {
                if (snapshot.hasData)
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: SwitchListTile(
                            secondary: Icon(
                              MuckeIcons.link_prev,
                              color: song.previous
                                  ? utils.linkColor(true, false)
                                  : utils.linkColor(true, false).withOpacity(0.5),
                            ),
                            value: song.previous,
                            onChanged: snapshot.data![0]
                                ? null
                                : (_) => musicDataStore.togglePreviousSongLink(song),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Container(width: 1.0, height: 24.0, color: DARK2),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: SwitchListTile(
                            secondary: Icon(
                              MuckeIcons.link_next,
                              color: song.next
                                  ? utils.linkColor(false, true)
                                  : utils.linkColor(false, true).withOpacity(0.5),
                            ),
                            value: song.next,
                            onChanged: snapshot.data![1]
                                ? null
                                : (_) => musicDataStore.toggleNextSongLink(song),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                          ),
                        ),
                      ],
                    ),
                  );
                else
                  return Container();
              }),
        if (widget.enableQueueActions) ...[
          ListTile(
            title: Text(L10n.of(context)!.playNext),
            leading: const Icon(Icons.play_arrow_rounded),
            onTap: () {
              audioStore.playNext([song]);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          ListTile(
            title: Text(L10n.of(context)!.appendToQueued),
            leading: const Icon(Icons.play_arrow_rounded),
            onTap: () {
              audioStore.appendToNext([song]);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          ListTile(
            title: Text(L10n.of(context)!.addToQueue),
            leading: const Icon(Icons.queue_rounded),
            onTap: () {
              audioStore.addToQueue([song]);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
        AddToPlaylistTile(songs: [song], musicDataStore: musicDataStore),
        ListTile(
          title: Text(L10n.of(context)!.blockFromLibrary),
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
