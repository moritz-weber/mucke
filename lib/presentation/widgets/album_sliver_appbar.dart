import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/album.dart';
import '../utils.dart' as utils;

class AlbumSliverAppBar extends StatelessWidget {
  const AlbumSliverAppBar({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      pinned: true,
      expandedHeight: 250.0,
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        title: Text(
          album.title,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        background: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Image(
                image: utils.getAlbumImage(album.albumArtPath),
              ),
            ),
            Container(
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
