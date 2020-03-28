import 'package:flutter/material.dart';

import '../utils.dart' as utils;

class AlbumArtListTile extends StatelessWidget {
  const AlbumArtListTile(
      {Key key, this.title, this.subtitle, this.albumArtPath, this.onTap})
      : super(key: key);

  final String title;
  final String subtitle;
  final String albumArtPath;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Card(
        child: utils.getAlbumImage(albumArtPath),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      title: Text(
        title,
      ),
      subtitle: Text(
        subtitle,
      ),
      onTap: () => onTap(),
    );
  }
}
