import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../theming.dart';
import '../utils.dart' as utils;

class SongListTile extends StatelessWidget {
  const SongListTile(
      {Key key, this.song, this.onTap, this.inAlbum, this.onTapMore})
      : super(key: key);

  final Song song;
  final bool inAlbum;
  final Function onTap;
  final Function onTapMore;

  @override
  Widget build(BuildContext context) {
    final Widget leading = inAlbum
        ? Center(child: Text('${song.discNumber} - ${song.trackNumber}'))
        : Image(
            image: utils.getAlbumImage(song.albumArtPath),
            fit: BoxFit.cover,
          );

    final Widget subtitle = inAlbum
        ? Text('${song.artist}')
        : Text('${song.artist} • ${song.album}');

    final EdgeInsets padding = (onTapMore != null)
        ? const EdgeInsets.only(left: 8.0)
        : const EdgeInsets.only(left: 8.0, right: 16.0);

    return ListTile(
      contentPadding: padding,
      leading: SizedBox(
        height: 56,
        width: 56,
        child: leading,
      ),
      title: Text(
        song.title,
      ),
      subtitle: subtitle,
      onTap: () => onTap(),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (song.blocked)
            Icon(
              Icons.remove_circle_outline,
              size: 14.0,
              color: RASPBERRY.withOpacity(0.4),
            ),
          if (onTapMore != null)
            IconButton(
              icon: const Icon(Icons.more_vert),
              iconSize: 20.0,
              onPressed: () => onTapMore(),
            ),
        ],
      ),
    );
  }
}
