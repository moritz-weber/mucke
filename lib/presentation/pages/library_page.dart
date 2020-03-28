import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mosh/domain/entities/album.dart';

import '../state/music_store.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key key, @required this.store}) : super(key: key);

  final MusicStore store;

  Image getAlbumImage(Album album) {
    if (album.albumArtPath == null || !File(album.albumArtPath).existsSync()) {
      return Image.asset('assets/no_cover.jpg');
    }
    return Image.file(File(album.albumArtPath));
  }

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
        final ObservableFuture<List<Album>> future = store.albumsFuture;

        switch (future.status) {
          case FutureStatus.pending:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                Text('Loading items...'),
              ],
            );

          case FutureStatus.rejected:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Failed to load items.',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            );

          case FutureStatus.fulfilled:
            final List<Album> albums = future.result as List<Album>;
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: albums.length,
              itemBuilder: (_, index) {
                final album = albums[index];
                return ListTile(
                  leading: Card(
                    child: getAlbumImage(album),
                  ),
                  title: Text(
                    '${album.title}, ${album.artist}, ${album.year}',
                  ),
                );
              },
            );
        }
        return Center(
          child: Text('Library Page'),
        );
      });
}
