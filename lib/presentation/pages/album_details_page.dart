import 'package:flutter/material.dart';

import '../../domain/entities/album.dart';
import '../utils.dart' as utils;

class AlbumDetailsPage extends StatelessWidget {
  const AlbumDetailsPage({Key key, @required this.album}) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          utils.getAlbumImage(album.albumArtPath),
        ],
      ),
    );
  }
}
