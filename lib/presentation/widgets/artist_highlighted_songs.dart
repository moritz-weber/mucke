import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import 'song_list_tile.dart';

class ArtistHighlightedSongs extends StatelessWidget {
  const ArtistHighlightedSongs({Key key, this.songs, this.onTap, this.onTapPlay}) : super(key: key);

  final List<Song> songs;
  final Function onTap;
  final Function onTapPlay;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) {
          final Song song = songs[index];
          return SongListTile(
            song: song
          );
        },
        childCount: songs.length,
      ),
    );
  }
}
