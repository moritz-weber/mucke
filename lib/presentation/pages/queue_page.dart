import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:reorderables/reorderables.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../theming.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('QueuePage.build');
    final AudioStore audioStore = GetIt.I<AudioStore>();

    final ObservableStream<int> queueIndexStream = audioStore.queueIndexStream;
    final initialIndex = max((queueIndexStream.value ?? 0) - 2, 0);
    final ScrollController _scrollController =
        ScrollController(initialScrollOffset: initialIndex * 72.0);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          leadingWidth: 60.0,
          title: const Text(
            'Currently Playing',
            style: TEXT_HEADER,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.play_arrow_outlined),
              onPressed: () {
                _scrollController.animateTo(
                  max((queueIndexStream.value ?? 0) - 2, 0) * 72.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              },
            )
          ],
          centerTitle: true,
        ),
        body: Observer(
          builder: (BuildContext context) {
            print('QueuePage.build -> Observer.build');
            final ObservableStream<List<Song>> queueStream = audioStore.queueStream;

            switch (queueStream.status) {
              case StreamStatus.active:
                final int activeIndex = queueIndexStream.value ?? -1;
                return Scrollbar(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      ReorderableSliverList(
                        delegate: ReorderableSliverChildBuilderDelegate(
                          (context, int index) {
                            final Song? song = queueStream.value?[index];
                            if (song == null) return Container();
                            return Dismissible(
                              key: ValueKey(song.path),
                              child: SongListTile(
                                song: song,
                                highlight: index == activeIndex,
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
                                    song: song,
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {
                                audioStore.removeQueueIndex(index);
                              },
                            );
                          },
                          childCount: queueStream.value?.length,
                        ),
                        onReorder: (oldIndex, newIndex) =>
                            audioStore.moveQueueItem(oldIndex, newIndex),
                      )
                    ],
                  ),
                );
              case StreamStatus.waiting:
              case StreamStatus.done:
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
