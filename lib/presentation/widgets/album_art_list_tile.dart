import 'package:flutter/material.dart';

import '../theming.dart';
import '../utils.dart' as utils;

class AlbumArtListTile extends StatelessWidget {
  const AlbumArtListTile(
      {Key key, this.title, this.subtitle, this.albumArtPath, this.onTap, this.highlight = false})
      : super(key: key);

  final String title;
  final String subtitle;
  final String albumArtPath;
  final Function onTap;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 56,
        width: 56,
        child: Image(
          image: utils.getAlbumImage(albumArtPath),
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: TEXT_SMALL_SUBTITLE.copyWith(color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => onTap(),
      tileColor: highlight ? Colors.white10 : Colors.transparent,
    );
  }
}
