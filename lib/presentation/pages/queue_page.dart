import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../widgets/album_art_list_tile.dart';
import '../widgets/album_background.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('QueuePage.build');
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    final ObservableStream<int> queueIndexStream = audioStore.queueIndexStream;
    final initialIndex = max(((queueIndexStream?.value) ?? 0) - 2, 0);
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
                final int activeIndex = queueIndexStream.value;
                return AlbumBackground(
                  song: audioStore.currentSong,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x55000000),
                      Color(0x55000000),
                    ],
                    stops: [
                      0.0,
                      1.0,
                    ],
                  ),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      ReorderableSliverList(
                        delegate: ReorderableSliverChildBuilderDelegate(
                          (context, int index) {
                            final song = queueStream.value[index];
                            return Dismissible(
                              key: ValueKey(song.path),
                              child: AlbumArtListTile(
                                title: song.title,
                                subtitle: '${song.artist}',
                                albumArtPath: song.albumArtPath,
                                highlight: index == activeIndex,
                                onTap: () => audioStore.setIndex(index),
                              ),
                              onDismissed: (direction) {
                                audioStore.removeQueueIndex(index);
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${song.title} removed'),
                                  ),
                                );
                              },
                            );
                          },
                          childCount: queueStream.value.length,
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
