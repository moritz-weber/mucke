import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../theming.dart';
import '../utils.dart' as utils;

enum Subtitle { artist, artistAlbum, stats }

class SongListTile extends StatelessWidget {
  const SongListTile(
      {Key? key,
      required this.song,
      required this.onTap,
      required this.onTapMore,
      this.showAlbum = true,
      this.subtitle = Subtitle.artist})
      : super(key: key);

  final Song song;
  final Function onTap;
  final Function onTapMore;
  final bool showAlbum;
  final Subtitle subtitle;

  @override
  Widget build(BuildContext context) {
    final Widget leading = showAlbum
        ? Image(
            image: utils.getAlbumImage(song.albumArtPath),
            fit: BoxFit.cover,
          )
        : Center(child: Text('${song.trackNumber}'));

    Widget subtitleWidget;
    switch (subtitle) {
      case Subtitle.artist:
        subtitleWidget = Text(
          song.artist,
          style: TEXT_SMALL_SUBTITLE.copyWith(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
        break;
      case Subtitle.artistAlbum:
        subtitleWidget = Text(
          '${song.artist} • ${song.album}',
          style: TEXT_SMALL_SUBTITLE.copyWith(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
        break;
      case Subtitle.stats:
        subtitleWidget = Row(
          children: [
            const Icon(
              Icons.favorite,
              size: 12.0,
            ),
            const SizedBox(width: 2.0),
            Text(
              '${song.likeCount}',
              style: TEXT_SMALL_SUBTITLE.copyWith(color: Colors.white),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.play_arrow,
              size: 12.0,
            ),
            const SizedBox(width: 2.0),
            Text(
              '${song.playCount}',
              style: TEXT_SMALL_SUBTITLE.copyWith(color: Colors.white),
            ),
          ],
        );
        break;
    }

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
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitleWidget,
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
