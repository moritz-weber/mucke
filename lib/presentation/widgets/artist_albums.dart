import 'package:flutter/material.dart';

import '../../domain/entities/album.dart';
import 'album_list_tile_extended.dart';

class ArtistAlbumList extends StatelessWidget {
  const ArtistAlbumList({Key key, this.albums, this.onTap}) : super(key: key);

  final List<Album> albums;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (_, int index) {
        final Album album = albums[index];
        return AlbumListTileExtended(
          title: album.title,
          subtitle: album.pubYear.toString(),
          albumArtPath: album.albumArtPath,
          onTap: () => onTap(album),
        );
      },
    );
  }
}
