import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/artist.dart';
import '../pages/artist_details_page.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';

class HighlightArtist extends StatelessWidget {
  const HighlightArtist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final MusicDataStore musicDataStore = GetIt.I<MusicDataStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return Observer(
      builder: (context) {
        final Artist? artist = musicDataStore.artistOfDay.value;
        if (artist == null) return Container();

        return GestureDetector(
          onTap: () => navStore.pushOnLibrary(
            MaterialPageRoute<Widget>(
              builder: (context) => ArtistDetailsPage(artist: artist),
            ),
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 8,
                  offset: Offset(0, 1),
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
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
                          // child: Image(
                          //   image: getAlbumImage(artist.albumArtPath),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Artist of the Day'.toUpperCase(),
                            style: TEXT_SMALL_HEADLINE,
                          ),
                          Container(height: 6.0),
                          Text(
                            artist.name,
                            style: Theme.of(context).textTheme.headline4,
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
                    onPressed: () => {}, //audioStore.playArtist(artist),
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
