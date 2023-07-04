import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/playable.dart';
import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    print('SongsPage.build');
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final AudioStore audioStore = GetIt.I<AudioStore>();

    super.build(context);
    return Observer(builder: (_) {
      print('SongsPage.build -> Observer.builder');

      final songStream = musicDataStore.songStream;

      switch (songStream.status) {
        case StreamStatus.active:
          final List<Song> songs = songStream.value ?? [];
          return Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: songs.length,
              itemBuilder: (_, int index) {
                final Song song = songs[index];
                return SongListTile(
                  song: song,
                  onTap: () => audioStore.playSong(index, songs, AllSongs()),
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
                );
              },
            ),
          );
        case StreamStatus.waiting:
        case StreamStatus.done:
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text('Loading items...'),
            ],
          );
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
