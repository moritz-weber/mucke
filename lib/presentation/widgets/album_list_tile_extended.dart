import 'package:flutter/material.dart';

import '../theming.dart';
import '../utils.dart' as utils;

class AlbumListTileExtended extends StatelessWidget {
  const AlbumListTileExtended(
      {Key key, this.title, this.subtitle, this.albumArtPath, this.onTap, this.highlight = false, this.onTapPlay})
      : super(key: key);

  final String title;
  final String subtitle;
  final String albumArtPath;
  final Function onTap;
  final bool highlight;
  final Function onTapPlay;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              SizedBox(
                height: 72,
                width: 72,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.0)),
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                    image: utils.getAlbumImage(albumArtPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                        maxLines: 2,
                      ),
                      Text(
                        subtitle,
                        style: TEXT_SMALL_SUBTITLE,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.play_circle_fill_rounded),
                iconSize: 40.0,
                onPressed: () => onTapPlay(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
