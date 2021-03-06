import 'package:flutter/material.dart';

import '../../domain/entities/song.dart';
import '../theming.dart';
import '../utils.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt({Key key, this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 1)),
          ],
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image(
                image: getAlbumImage(song.albumArtPath),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      song.title,
                      overflow: TextOverflow.ellipsis,
                      // softWrap: false,
                      maxLines: 2,
                      style: TEXT_BIG.copyWith(
                        shadows: [
                          const Shadow(
                            blurRadius: 2.0,
                            color: Colors.black87,
                            offset: Offset(.5, .5),
                          ),
                          const Shadow(
                            blurRadius: 8.0,
                            color: Colors.black54,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      song.artist,
                      style: TEXT_SUBTITLE.copyWith(
                        color: Colors.grey[100],
                        shadows: [
                          const Shadow(
                            blurRadius: 2.0,
                            color: Colors.black87,
                            offset: Offset(.5, .5),
                          ),
                          const Shadow(
                            blurRadius: 8.0,
                            color: Colors.black54,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
