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

class Highlight extends StatelessWidget {
  const Highlight({Key? key}) : super(key: key);

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
          onTap: () => navStore.pushOnLibrary(
            MaterialPageRoute<Widget>(
              builder: (context) => AlbumDetailsPage(album: album),
            ),
          ),
          child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 10,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.0),
                          ),
                          child: Image(
                            image: getAlbumImage(album.albumArtPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 23,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.play_circle_fill_rounded,
                        size: 48.0,
                      ),
                      iconSize: 48.0,
                      onPressed: () => audioStore.playAlbum(album),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
