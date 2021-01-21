import 'package:flutter/material.dart';

import '../../domain/entities/album.dart';
import 'album_list_tile_extended.dart';

class ArtistAlbumSliverList extends StatelessWidget {
  const ArtistAlbumSliverList({Key key, this.albums, this.onTap, this.onTapPlay}) : super(key: key);

  final List<Album> albums;
  final Function onTap;
  final Function onTapPlay;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) {
          final Album album = albums[index];
          return AlbumListTileExtended(
            title: album.title,
            subtitle: album.pubYear.toString(),
            albumArtPath: album.albumArtPath,
            onTap: () => onTap(album),
            onTapPlay: () => onTapPlay(album),
          );
        },
        childCount: albums.length,
      ),
    );
  }
}
