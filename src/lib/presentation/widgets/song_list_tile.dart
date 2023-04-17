import 'package:flutter/material.dart';

import '../../domain/entities/queue_item.dart';
import '../../domain/entities/song.dart';
import '../theming.dart';
import '../utils.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({
    Key? key,
    required this.song,
    required this.onTap,
    required this.onTapMore,
    this.highlight = false,
    this.showPlayCount = false,
    this.source = QueueItemSource.original,
    required this.onSelect,
    this.isSelectEnabled = false,
    this.isSelected = false,
  }) : super(key: key);

  final Song song;
  final Function onTap;
  final Function onTapMore;
  final bool highlight;
  final bool showPlayCount;
  final QueueItemSource source;
  final bool isSelectEnabled;
  final bool isSelected;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      contentPadding: const EdgeInsets.only(left: HORIZONTAL_PADDING),
      minVerticalPadding: 8.0,
      leading: SizedBox(
        height: 56,
        width: 56,
        child: Image(
          image: getAlbumImage(song.albumArtPath),
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          if (showPlayCount)
          Row(
          children: [
            Text(
              '${song.playCount}',
              style: TEXT_SMALL_SUBTITLE,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 2.0),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 13.0,
              ),
            ),

          ],),
          if (source != QueueItemSource.original)
            Icon(
              source == QueueItemSource.added ? Icons.add_circle_rounded : Icons.link_rounded,
              color: LIGHT1,
              size: 13.0,
            ),
          if (source != QueueItemSource.original)
            const Text(
              ' • ',
              style: TEXT_SMALL_SUBTITLE,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          Icon(
            likeCountIcon(song.likeCount),
            size: 13.0,
            color: likeCountColor(song.likeCount),
          ),
          if (song.blockLevel > 0)
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Icon(
                blockLevelIcon(song.blockLevel),
                size: 13.0,
                color: Colors.white38,
              ),
            ),
          if (song.next || song.previous)
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Icon(
                linkIcon(song.previous, song.next),
                size: 13.0,
                color: linkColor(song.previous, song.next).withOpacity(0.7),
              ),
            ),
          Expanded(
            child: Text(
              ' • ${song.artist}',
              style: TEXT_SMALL_SUBTITLE,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      onTap: () => onTap(),
      tileColor: highlight ? Colors.white10 : Colors.transparent,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isSelectEnabled)
            IconButton(
              icon: const Icon(Icons.more_vert_rounded),
              iconSize: 20.0,
              onPressed: () => onTapMore(),
            )
          else
            Checkbox(value: isSelected, onChanged: (value) => onSelect(value)),
        ],
      ),
    );
  }
}
