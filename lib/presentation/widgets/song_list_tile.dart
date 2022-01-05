import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../theming.dart';
import '../utils.dart' as utils;
import '../utils.dart';

enum Subtitle { artist, artistAlbum, stats }

class SongListTile extends StatelessWidget {
  const SongListTile({
    Key? key,
    required this.song,
    required this.onTap,
    required this.onTapMore,
    this.highlight = false,
    this.showAlbum = true,
    this.subtitle = Subtitle.artist,
  }) : super(key: key);

  final Song song;
  final Function onTap;
  final Function onTapMore;
  final bool highlight;
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

    return ListTile(
      contentPadding: const EdgeInsets.only(left: HORIZONTAL_PADDING),
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
      tileColor: highlight ? Colors.white10 : Colors.transparent,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (song.blockLevel > 0)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(
                blockLevelIcon(song.blockLevel),
                size: 16.0,
                color: Colors.white38,
              ),
            ),
          Icon(
            likeCountIcon(song.likeCount),
            size: 16.0,
            color: song.likeCount == 3
                ? LIGHT2
                : Colors.white.withOpacity(
                    0.2 + 0.18 * song.likeCount,
                  ),
          ),
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
