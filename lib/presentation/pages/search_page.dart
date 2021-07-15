import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/search_page_store.dart';
import '../theming.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';

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
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: HORIZONTAL_PADDING - 8.0,
              right: HORIZONTAL_PADDING - 8.0,
              bottom: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TEXT_HEADER.copyWith(color: Colors.white),
                fillColor: Colors.white10,
                filled: true,
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none, gapPadding: 0.0),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none, gapPadding: 0.0),
                contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              ),
              
              onChanged: (text) {
                searchStore.search(text);
              },
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
