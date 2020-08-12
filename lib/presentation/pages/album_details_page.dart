import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../utils.dart' as utils;
import '../widgets/album_art_list_tile.dart';

class AlbumDetailsPage extends StatelessWidget {
  const AlbumDetailsPage({Key key, @required this.album}) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = Provider.of<MusicDataStore>(context);
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) => CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.dark,
            pinned: true,
            expandedHeight: 250.0,
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              title: Text(
                album.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              background: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Image(
                      image: utils.getAlbumImage(album.albumArtPath),
                    ),
                  ),
                  Container(
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                if (index.isEven) {
                  final songIndex = (index / 2).round();

                  final Song song = musicDataStore.albumSongs[songIndex];
                  return AlbumArtListTile(
                    title: song.title,
                    subtitle: '${song.artist}',
                    albumArtPath: song.albumArtPath,
                    onTap: () => audioStore.playSong(songIndex, musicDataStore.albumSongs),
                  );
                }
                return const Divider(
                  height: 4.0,
                );
              },
              semanticIndexCallback: (Widget widget, int localIndex) {
                if (localIndex.isEven) {
                  return localIndex ~/ 2;
                }
                return null;
              },
              childCount: musicDataStore.albumSongs.length * 2,
            ),
          ),
        ],
      ),
    );
  }
}
