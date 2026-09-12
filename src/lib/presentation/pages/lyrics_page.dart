import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/presentation/utils.dart';

import '../../domain/entities/song.dart';
import '../state/navigation_store.dart';
import '../theming.dart';

/// Displays the lyrics of a single song in a full page.
class LyricsPage extends StatelessWidget {
  const LyricsPage({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(song.title, style: TEXT_HEADER_S),
            Text(
              '${song.artist} • ${song.album}',
              style: TEXT_SMALL_SUBTITLE,
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => navStore.pop(context),
        ),
        actions: song.albumArtPath == null
            ? null
            : [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image(
                    image: getAlbumImage(song.albumArtPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
        actionsPadding: const EdgeInsets.only(right: 8.0),
        titleSpacing: 0.0,
        backgroundColor: bgColor(song.color),
      ),
      body: Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(HORIZONTAL_PADDING),
          child: Text(
            song.plainLyrics ?? '',
            style: const TextStyle(
              fontSize: 18.0,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}