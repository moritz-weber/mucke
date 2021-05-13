import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/song.dart';
import '../state/album_page_store.dart';
import '../state/audio_store.dart';
import '../theming.dart';
import '../widgets/album_sliver_appbar.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';

class AlbumDetailsPage extends StatefulWidget {
  const AlbumDetailsPage({Key key, @required this.album}) : super(key: key);

  final Album album;

  @override
  _AlbumDetailsPageState createState() => _AlbumDetailsPageState();
}

class _AlbumDetailsPageState extends State<AlbumDetailsPage> {
  AlbumPageStore store;

  @override
  void initState() {
    super.initState();

    store = GetIt.I<AlbumPageStore>(param1: widget.album);
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final songsByDisc = _songsByDisc(store.albumSongStream.value);

        return CustomScrollView(
          slivers: <Widget>[
            AlbumSliverAppBar(
              album: widget.album,
            ),
            for (int d = 0; d < songsByDisc.length; d++)
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    if (songsByDisc.length > 1 && d > 0) Container(height: 8.0),
                    if (songsByDisc.length > 1)
                      ListTile(
                        title: Text('Disc ${d + 1}', style: TEXT_HEADER),
                        leading: const SizedBox(width: 56, child: Icon(Icons.album)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                    if (songsByDisc.length > 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: HORIZONTAL_PADDING,
                        ),
                        child: Container(
                          height: 1.0,
                          color: Colors.white10,
                        ),
                      ),
                    for (int s = 0; s < songsByDisc[d].length; s++)
                      SongListTile(
                        song: songsByDisc[d][s],
                        showAlbum: false,
                        onTap: () => audioStore.playSong(
                          s + _calcOffset(d, songsByDisc),
                          store.albumSongStream.value,
                        ),
                        onTapMore: () => SongBottomSheet()(songsByDisc[d][s], context),
                      )
                  ],
                ),
              )
          ],
        );
      },
    );
  }

  List<List<Song>> _songsByDisc(List<Song> songs) {
    final discs = [<Song>[]];
    int currentDisc = 1;

    for (final song in songs) {
      if (song.discNumber == currentDisc) {
        discs.last.add(song);
      } else {
        discs.add([song]);
        currentDisc = song.discNumber;
      }
    }

    return discs;
  }

  int _calcOffset(int disc, List<List> discs) {
    int offset = 0;
    for (int i = 0; i < disc; i++) {
      offset += discs[i].length;
    }
    return offset;
  }
}
