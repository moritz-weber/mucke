import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../state/artist_page_store.dart';
import '../state/audio_store.dart';
import 'song_bottom_sheet.dart';
import 'song_list_tile.dart';

class ArtistHighlightedSongs extends StatelessWidget {
  const ArtistHighlightedSongs({
    Key? key,
    required this.artistPageStore,
  }) : super(key: key);

  final ArtistPageStore artistPageStore;

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return Observer(
      builder: (BuildContext context) {
        final songs = artistPageStore.artistHighlightedSongStream.value ?? [];
        final songsHead = songs.take(5).toList();

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, int index) {
              final Song song = songsHead[index];
              return SongListTile(
                song: song,
                showAlbum: true,
                subtitle: Subtitle.stats,
                onTap: () => audioStore.playSong(index, songs),
                onTapMore: () => SongBottomSheet()(song, context),
              );
            },
            childCount: songsHead.length,
          ),
        );
      },
    );
  }
}
