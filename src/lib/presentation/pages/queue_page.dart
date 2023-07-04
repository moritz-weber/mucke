import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:reorderables/reorderables.dart';

import '../../domain/entities/queue_item.dart';
import '../../domain/entities/song.dart';
import '../l10n_utils.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/queue_page_store.dart';
import '../theming.dart';
import '../widgets/bottom_sheet/add_to_playlist.dart';
import '../widgets/custom_modal_bottom_sheet.dart';
import '../widgets/exclude_level_options.dart';
import '../widgets/like_count_options.dart';
import '../widgets/queue_control_bar.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('QueuePage.build');
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final QueuePageStore queuePageStore = GetIt.I<QueuePageStore>();
    queuePageStore.reset();

    final ObservableStream<int?> queueIndexStream = audioStore.queueIndexStream;
    final initialIndex = max((queueIndexStream.value ?? 0) - 2, 0);
    final ScrollController _scrollController =
        ScrollController(initialScrollOffset: initialIndex * 72.0);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: HORIZONTAL_PADDING),
          child: SizedBox(
            width: 56.0,
            child: IconButton(
              icon: const Icon(Icons.expand_more_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        leadingWidth: 56 + HORIZONTAL_PADDING,
        toolbarHeight: 80.0,
        title: Observer(
          builder: (context) {
            final playable = audioStore.playableStream.value;
            final numAvailableSongs = audioStore.numAvailableSongs;

            Widget subTitle = Container();

            if (playable != null) {
              subTitle = Text(
                playable.repr(context),
                maxLines: 1,
              );
            }

            String text = L10n.of(context)!.nSongsInQueue(audioStore.queueLength);
            if (numAvailableSongs > 0) text += ', ${L10n.of(context)!.moreAvailable(numAvailableSongs)}';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subTitle,
                const SizedBox(height: 4.0),
                Text(
                  text,
                  style: TEXT_SMALL_SUBTITLE.copyWith(color: Colors.white70),
                ),
              ],
            );
          },
        ),
        centerTitle: false,
        actions: [
          Observer(
            builder: (context) {
              final isMultiSelectEnabled = queuePageStore.isMultiSelectEnabled;

              if (isMultiSelectEnabled)
                return IconButton(
                  key: GlobalKey(),
                  icon: const Icon(Icons.more_vert_rounded),
                  onPressed: () => _openMultiselectMenu(context),
                );

              return Container();
            },
          ),
          Observer(
            builder: (context) {
              final isMultiSelectEnabled = queuePageStore.isMultiSelectEnabled;
              final isAllSelected = queuePageStore.isAllSelected;

              if (isMultiSelectEnabled)
                return IconButton(
                  key: GlobalKey(),
                  icon: isAllSelected
                      ? const Icon(Icons.deselect_rounded)
                      : const Icon(Icons.select_all_rounded),
                  onPressed: () {
                    if (isAllSelected)
                      queuePageStore.deselectAll();
                    else
                      queuePageStore.selectAll();
                  },
                );

              return Container();
            },
          ),
          Observer(builder: (context) {
            final isMultiSelectEnabled = queuePageStore.isMultiSelectEnabled;
            return IconButton(
              key: const ValueKey('QUEUE_MULTISELECT'),
              icon: isMultiSelectEnabled
                  ? const Icon(Icons.close_rounded)
                  : const Icon(Icons.checklist_rtl_rounded),
              onPressed: () => queuePageStore.toggleMultiSelect(),
            );
          })
        ],
      ),
      body: Observer(
        builder: (BuildContext context) {
          print('QueuePage.build -> Observer.build');
          final queue = audioStore.queue;
          final isMultiSelectEnabled = queuePageStore.isMultiSelectEnabled;
          final isSelected = queuePageStore.isSelected.toList();

          while (isSelected.length < queue.length) isSelected.add(false);

          final int activeIndex = queueIndexStream.value ?? -1;
          return Scrollbar(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                ReorderableSliverList(
                  delegate: ReorderableSliverChildBuilderDelegate(
                    (context, int index) {
                      final QueueItem? queueItem = queue[index];
                      if (queueItem == null) return Container();
                      return Dismissible(
                        key: ValueKey(queueItem.toString()),
                        child: SongListTile(
                          song: queueItem.song,
                          highlight: index == activeIndex,
                          source: queueItem.source,
                          isSelectEnabled: isMultiSelectEnabled,
                          isSelected: isMultiSelectEnabled && isSelected[index],
                          onTap: () async {
                            await audioStore.seekToIndex(index);
                            audioStore.play();
                          },
                          onTapMore: () => showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => SongBottomSheet(
                              song: queueItem.song,
                              enableQueueActions: false,
                              numNavPop: 3,
                            ),
                          ),
                          onSelect: (bool selected) =>
                              queuePageStore.setSelected(selected, index),
                        ),
                        background: Container(
                          width: double.infinity,
                          color: RED,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.playlist_remove_rounded,
                                  color: Colors.white,
                                ),
                                Icon(
                                  Icons.playlist_remove_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          audioStore.removeQueueIndices([index]);
                        },
                        confirmDismiss: (direction) async => !isMultiSelectEnabled,
                      );
                    },
                    childCount: queue.length,
                  ),
                  onReorder: (oldIndex, newIndex) => audioStore.moveQueueItem(oldIndex, newIndex),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const QueueControlBar(),
    );
  }

  Future<void> _openMultiselectMenu(BuildContext context) async {
    final audioStore = GetIt.I<AudioStore>();
    final queuePageStore = GetIt.I<QueuePageStore>();
    final musicDataStore = GetIt.I<MusicDataStore>();

    final isSelected = queuePageStore.isSelected.toList();
    final indeces = <int>[];
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) indeces.add(i);
    }

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Observer(builder: (context) {
        final allSongs = audioStore.queue.map((e) => e.song).toList();
        while (isSelected.length < allSongs.length) isSelected.add(false);

        final songs = <Song>[];
        for (int i = 0; i < allSongs.length; i++) {
          if (isSelected[i]) songs.add(allSongs[i]);
        }

        return MyBottomSheet(
          widgets: [
            ListTile(
              title: Text(L10n.of(context)!.nSongsSelected(songs.length).capitalize()),
            ),
            LikeCountOptions(songs: songs, musicDataStore: musicDataStore),
            Container(
              height: 1,
              color: Colors.transparent,
            ),
            ExcludeLevelOptions(
              songs: songs,
              musicDataStore: musicDataStore,
              callback: () {
                queuePageStore.deselectAll();
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            ListTile(
              title: Text(L10n.of(context)!.removeFromQueue),
              leading: const Icon(Icons.playlist_remove_rounded),
              onTap: () async {
                await audioStore.removeQueueIndices(indeces);
                Navigator.of(context, rootNavigator: true).pop();
                queuePageStore.deselectAll();
              },
            ),
            AddToPlaylistTile(songs: songs, musicDataStore: musicDataStore),
          ],
        );
      }),
    );
  }
}
