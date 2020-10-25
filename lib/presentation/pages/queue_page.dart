import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../widgets/album_art_list_tile.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('QueuePage.build');
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              Observer(
            builder: (BuildContext context) {
              print('QueuePage.build -> Observer.build');
              final ObservableStream<List<Song>> queueStream =
                  audioStore.queueStream;
              final ObservableStream<int> queueIndexStream =
                  audioStore.queueIndexStream;

              switch (queueStream.status) {
                case StreamStatus.active:
                  return ReorderableListView(
                    children: queueStream.value.asMap().entries.map((e) {
                      final index = e.key;
                      final song = e.value;
                      return Dismissible(
                        key: ValueKey(song.path),
                        child: AlbumArtListTile(
                          title: song.title,
                          subtitle: '${song.artist} • ${song.album}',
                          albumArtPath: song.albumArtPath,
                          highlight: index == queueIndexStream.value,
                        ),
                        onDismissed: (direction) {
                          audioStore.removeQueueItem(index);
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${song.title} dismissed'),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    onReorder: (oldIndex, newIndex) =>
                        audioStore.moveQueueItem(oldIndex, newIndex),
                  );
                  return ListView.separated(
                    itemCount: queueStream.value.length,
                    itemBuilder: (_, int index) {
                      final Song song = queueStream.value[index];
                      return AlbumArtListTile(
                        title: song.title,
                        subtitle: '${song.artist} • ${song.album}',
                        albumArtPath: song.albumArtPath,
                        highlight: index == queueIndexStream.value,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      height: 4.0,
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
      ),
    );
  }
}
