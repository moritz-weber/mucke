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
      ),
      subtitle: Text(
        subtitle,
      ),
      onTap: () => onTap(),
    );
  }
}
