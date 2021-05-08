import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../theming.dart';
import '../utils.dart' as utils;

class SongListTile extends StatelessWidget {
  const SongListTile({Key key, this.song, this.onTap, this.showAlbum = false, this.onTapMore})
      : super(key: key);

  final Song song;
  final bool showAlbum;
  final Function onTap;
  final Function onTapMore;

  @override
  Widget build(BuildContext context) {
    final Widget leading = showAlbum
        ? Image(
            image: utils.getAlbumImage(song.albumArtPath),
            fit: BoxFit.cover,
          )
        : Center(child: Text('${song.trackNumber}'));

    final Widget subtitle =
        showAlbum ? Text('${song.artist} • ${song.album}') : Text('${song.artist}');

    final EdgeInsets padding = (onTapMore != null)
        ? const EdgeInsets.only(left: HORIZONTAL_PADDING)
        : const EdgeInsets.only(left: HORIZONTAL_PADDING, right: 16.0);

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
              color: Colors.white.withOpacity(0.4),
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
