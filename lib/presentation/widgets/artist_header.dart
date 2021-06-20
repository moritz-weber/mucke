import 'package:flutter/material.dart';

import '../../domain/entities/artist.dart';

class ArtistHeader extends StatelessWidget {
  const ArtistHeader({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    const double height = 144.0;
    return SliverAppBar(
      brightness: Brightness.dark,
      pinned: true,
      expandedHeight: height,
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      leading: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      titleSpacing: 48.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(
          bottom: 0.0,
          top: 0.0,
          left: 48.0,
          right: 48.0,
        ),
        title: Container(
          alignment: Alignment.center,
          height: height * 0.66,
          // color: Colors.red,
          child: Text(
            artist.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Colors.deepPurpleAccent,
                Colors.transparent,
                Theme.of(context).scaffoldBackgroundColor,
                // Colors.green,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
