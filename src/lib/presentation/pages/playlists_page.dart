import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/playlist.dart';
import '../../domain/entities/smart_list.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../widgets/play_shuffle_button.dart';
import '../widgets/playlist_cover.dart';
import 'playlist_form_page.dart';
import 'playlist_page.dart';
import 'smart_list_form_page.dart';
import 'smart_list_page.dart';

class PlaylistsPage extends StatefulWidget {
  const PlaylistsPage({Key? key}) : super(key: key);

  @override
  _PlaylistsPageState createState() => _PlaylistsPageState();
}

class _PlaylistsPageState extends State<PlaylistsPage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    print('PlaylistsPage.build');
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    super.build(context);
    return Observer(builder: (_) {
      print('PlaylistsPage.build -> Observer.builder');

      final smartLists = musicDataStore.smartListsStream.value ?? [];
      final playlists = musicDataStore.playlistsStream.value ?? [];
      return Scaffold(
        body: Scrollbar(
          controller: _scrollController,
          child: ListView.separated(
            controller: _scrollController,
            itemCount: smartLists.length + playlists.length,
            itemBuilder: (_, int index) {
              if (index < smartLists.length) {
                final SmartList smartList = smartLists[index];
                return ListTile(
                  title: Text(smartList.name),
                  subtitle: const Text('Smart list'),
                  onTap: () => navStore.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SmartListPage(smartList: smartList),
                    ),
                  ),
                  trailing: PlayShuffleButton(
                    onPressed: () => audioStore.playSmartList(smartList),
                    shuffleMode: smartList.shuffleMode,
                    size: 40.0,
                  ),
                  leading: PlaylistCover(
                    gradient: smartList.gradient,
                    size: 56.0,
                    icon: smartList.icon,
                  ),
                );
              } else {
                final i = index - smartLists.length;
                final Playlist playlist = playlists[i];
                return ListTile(
                  title: Text(playlist.name),
                  subtitle: const Text('Playlist'),
                  onTap: () => navStore.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PlaylistPage(playlist: playlist),
                    ),
                  ),
                  trailing: PlayShuffleButton(
                    onPressed: () => audioStore.playPlaylist(playlist),
                    shuffleMode: playlist.shuffleMode,
                    size: 40.0,
                  ),
                  leading: PlaylistCover(
                    gradient: playlist.gradient,
                    size: 56.0,
                    icon: playlist.icon,
                  ),
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 4.0,
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          child: const Icon(Icons.add_rounded),
          activeChild: Transform.rotate(
            angle: pi / 4,
            child: const Icon(Icons.add_rounded),
          ),
          elevation: 8.0,
          isOpenOnStart: false,
          animationDuration: const Duration(milliseconds: 200),
          spacing: 4.0,
          spaceBetweenChildren: 4.0,
          useRotationAnimation: true,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.auto_awesome_rounded),
              backgroundColor: LIGHT2,
              foregroundColor: Colors.white,
              label: 'Add Smartlist',
              onTap: () => navStore.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SmartListFormPage(),
                ),
              ),
            ),
            SpeedDialChild(
              child: const Icon(Icons.playlist_add_rounded),
              backgroundColor: LIGHT2,
              foregroundColor: Colors.white,
              label: 'Add Playlist',
              onTap: () => navStore.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const PlaylistFormPage(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
