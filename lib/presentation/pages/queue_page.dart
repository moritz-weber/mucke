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

              switch (queueStream.status) {
                case StreamStatus.active:
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 8.0,
                    ),
                    child: ListView.separated(
                      itemCount: queueStream.value.length,
                      itemBuilder: (_, int index) {
                        final Song song = queueStream.value[index];
                        return AlbumArtListTile(
                          title: song.title,
                          subtitle: '${song.artist} • ${song.album}',
                          albumArtPath: song.albumArtPath,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 4.0,
                      ),
                    ),
                  );
                case StreamStatus.waiting:
                case StreamStatus.done:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
