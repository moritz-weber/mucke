import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/search_page_store.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';

import '../theming.dart';
import '../widgets/header.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    print('SearchPage.build');

    final searchStore = GetIt.I<SearchPageStore>();
    final audioStore = GetIt.I<AudioStore>();

    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: HORIZONTAL_PADDING),
            child: Header(title: 'Search'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: HORIZONTAL_PADDING,
              right: HORIZONTAL_PADDING,
              bottom: 16.0,
            ),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: 'Search'),
                  onChanged: (text) {
                    searchStore.search(text);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Observer(builder: (context) {
              final results = searchStore.searchResults;
              if (results.isEmpty) return Container();

              return ListView.builder(
                itemBuilder: (context, index) {
                  if (results[index] is Song) {
                    final song = results[index] as Song;
                    return SongListTile(
                      song: song,
                      onTap: () => audioStore.playSong(0, [song]),
                      onTapMore: () => SongBottomSheet()(song, context),
                    );
                  }
                  return Container();
                },
                itemCount: results.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}
