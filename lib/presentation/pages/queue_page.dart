import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:reorderables/reorderables.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../widgets/album_art_list_tile.dart';

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

    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (BuildContext context) {
            print('QueuePage.build -> Observer.build');
            final ObservableStream<List<Song>> queueStream = audioStore.queueStream;

            switch (queueStream.status) {
              case StreamStatus.active:
                final int activeIndex = queueIndexStream.value ?? -1;
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    ReorderableSliverList(
                      delegate: ReorderableSliverChildBuilderDelegate(
                        (context, int index) {
                          final Song? song = queueStream.value?[index];
                          if (song == null)
                           return Container();
                          return Dismissible(
                            key: ValueKey(song.path),
                            child: AlbumArtListTile(
                              title: song.title,
                              subtitle: '${song.artist}',
                              albumArtPath: song.albumArtPath,
                              highlight: index == activeIndex,
                              onTap: () => audioStore.seekToIndex(index),
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
