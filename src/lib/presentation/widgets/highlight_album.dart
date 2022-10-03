import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/album.dart';
import '../pages/album_details_page.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import '../utils.dart';

class HighlightAlbum extends StatelessWidget {
  const HighlightAlbum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return Observer(
      builder: (context) {
        final Album? album = musicDataStore.albumOfDay.value;
        if (album == null) return Container();

        return GestureDetector(
          onTap: () => navStore.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (context) => AlbumDetailsPage(album: album),
            ),
          ),
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100.0,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          boxShadow: const [
                            BoxShadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 0), spreadRadius: -1),
                          ],
                        ),
                        child: Image(
                          image: getAlbumImage(album.albumArtPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Album of the Day'.toUpperCase(),
                            style: TEXT_SMALL_HEADLINE,
                          ),
                          Container(height: 6.0),
                          Text(
                            album.title,
                            style: Theme.of(context).textTheme.headline4,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            album.artist,
                            style: TEXT_SMALL_SUBTITLE,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.play_circle_fill_rounded,
                      size: 48.0,
                    ),
                    iconSize: 48.0,
                    onPressed: () => audioStore.playAlbum(album),
                    splashRadius: 28.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
