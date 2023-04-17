import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../theming.dart';
import '../utils.dart';

class SongListTileNumbered extends StatelessWidget {
  const SongListTileNumbered({
    Key? key,
    required this.song,
    required this.onTap,
    required this.onTapMore,
    required this.onSelect,
    this.isSelectEnabled = false,
    this.isSelected = false,
  }) : super(key: key);

  final Song song;
  final Function onTap;
  final Function onTapMore;
  final bool isSelectEnabled;
  final bool isSelected;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: HORIZONTAL_PADDING),
      leading: SizedBox(
        height: 56,
        width: 40,
        child: Center(child: Text('${song.trackNumber}')),
      ),
      title: Text(
        song.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Text(
              '${msToTimeString(song.duration)} • ',
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
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
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
      onTap: () => onTap(),
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
