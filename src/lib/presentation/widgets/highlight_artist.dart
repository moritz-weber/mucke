import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/artist.dart';
import '../../domain/entities/shuffle_mode.dart';
import '../gradients.dart';
import '../pages/artist_details_page.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../theming.dart';
import 'play_shuffle_button.dart';
import 'playlist_cover.dart';

class HighlightArtist extends StatelessWidget {
  const HighlightArtist({required this.shuffleMode, Key? key}) : super(key: key);

  final ShuffleMode shuffleMode;

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
          onTap: () => navStore.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (context) => ArtistDetailsPage(artist: artist),
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
                  PlaylistCover(
                    gradient: CUSTOM_GRADIENTS['kashmir']!,
                    icon: Icons.person_rounded,
                    size: 100.0,
                    circle: true,
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
                  PlayShuffleButton(
                    onPressed: () => audioStore.playArtist(artist, shuffleMode),
                    size: 56.0,
                    shuffleMode: shuffleMode,
                  ),
                  const SizedBox(width: 4.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
