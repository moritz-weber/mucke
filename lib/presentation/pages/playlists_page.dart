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
import '../state/settings_store.dart';
import '../theming.dart';
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
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    super.build(context);
    return Observer(builder: (_) {
      print('PlaylistsPage.build -> Observer.builder');

      final smartLists = settingsStore.smartListsStream.value ?? [];
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
                  onTap: () => navStore.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SmartListPage(smartList: smartList),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_circle_fill_rounded, size: 32.0),
                    onPressed: () => audioStore.playSmartList(smartList),
                  ),
                );
              } else {
                final i = index - smartLists.length;
                final Playlist playlist = playlists[i];
                return ListTile(
                  title: Text(playlist.name),
                  onTap: () => navStore.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PlaylistPage(playlist: playlist),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_circle_fill_rounded, size: 32.0),
                    onPressed: () => audioStore.playPlaylist(playlist),
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

          // icon: Icons.add,
          // activeIcon: Icons.close,
          // tooltip: 'Open Speed Dial',
          // heroTag: 'speed-dial-hero-tag',
          elevation: 8.0,
          isOpenOnStart: false,
          animationSpeed: 200,
          spacing: 4.0,
          spaceBetweenChildren: 4.0,
          useRotationAnimation: true,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.auto_awesome),
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
              child: const Icon(Icons.playlist_add),
              backgroundColor: LIGHT2,
              foregroundColor: Colors.white,
              label: 'Add Playlist',
              onTap: () => _addPlaylist(context),
            ),
          ],
        ),
      );
    });
  }

  void _addPlaylist(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const _PlaylistForm();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PlaylistForm extends StatefulWidget {
  const _PlaylistForm({Key? key}) : super(key: key);

  @override
  _PlaylistFormState createState() => _PlaylistFormState();
}

class _PlaylistFormState extends State<_PlaylistForm> {
  final _controller = TextEditingController();

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
                musicDataStore.insertPlaylist(_controller.text);
                print('Created playlist with name: ${_controller.text}.');
                Navigator.pop(context);
              },
              child: const Text(
                'Create',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
