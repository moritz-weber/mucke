import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/smart_list.dart';
import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/smart_list_page_store.dart';
import '../theming.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';
import 'smart_list_form_page.dart';

class SmartListPage extends StatefulWidget {
  const SmartListPage({Key? key, required this.smartList}) : super(key: key);

  final SmartList smartList;

  @override
  _SmartListPageState createState() => _SmartListPageState();
}

class _SmartListPageState extends State<SmartListPage> {
  late SmartListPageStore store;

  @override
  void initState() {
    super.initState();
    store = GetIt.I<SmartListPageStore>(param1: widget.smartList);
    store.setupReactions();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();

    return SafeArea(
      child: Observer(
        builder: (context) {
          final songs = store.smartListSongStream.value ?? [];
          final smartList = store.smartListStream.value ?? widget.smartList;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                smartList.name,
                style: TEXT_HEADER,
              ),
              leading: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => SmartListFormPage(
                        smartList: smartList,
                      ),
                    ),
                  ),
                ),
              ],
              titleSpacing: 0.0,
            ),
            body: Scrollbar(
              child: ListView.separated(
                itemCount: songs.length,
                itemBuilder: (_, int index) {
                  final Song song = songs[index];
                  return SongListTile(
                    song: song,
                    showAlbum: true,
                    subtitle: Subtitle.artistAlbum,
                    onTap: () => audioStore.playSong(index, songs, smartList),
                    onTapMore: () => showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => SongBottomSheet(
                        song: song,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(
                  height: 4.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
