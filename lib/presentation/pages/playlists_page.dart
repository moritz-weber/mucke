import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/smart_list.dart';
import '../state/audio_store.dart';
import '../state/settings_store.dart';
import '../theming.dart';
import 'smart_list_page.dart';
import 'smart_lists_form_page.dart';

class PlaylistsPage extends StatefulWidget {
  const PlaylistsPage({Key? key}) : super(key: key);

  @override
  _PlaylistsPageState createState() => _PlaylistsPageState();
}

class _PlaylistsPageState extends State<PlaylistsPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print('PlaylistsPage.build');
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();

    super.build(context);
    return Observer(builder: (_) {
      print('PlaylistsPage.build -> Observer.builder');

      final smartLists = settingsStore.smartListsStream.value ?? [];
      return Scaffold(
        body: ListView.separated(
          itemCount: smartLists.length,
          itemBuilder: (_, int index) {
            final SmartList smartList = smartLists[index];
            return ListTile(
              title: Text(smartList.name),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => SmartListPage(smartList: smartList),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.play_circle_fill_rounded, size: 32.0),
                onPressed: () => audioStore.playSmartList(smartList),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 4.0,
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
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const SmartListFormPage(),
                ),
              ),
            ),
            SpeedDialChild(
              child: const Icon(Icons.playlist_add),
              backgroundColor: Colors.grey, //LIGHT2,
              foregroundColor: Colors.white,
              label: 'Add Playlist',
              onTap: () => debugPrint('SECOND CHILD'),
            ),
          ],
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
