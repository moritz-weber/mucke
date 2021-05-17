import 'package:flutter/material.dart';

import '../theming.dart';
import 'next_song.dart';

class CurrentlyPlayingHeader extends StatelessWidget {
  const CurrentlyPlayingHeader({Key key, this.onTap}) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.expand_more),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onTap(context),
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Next up'.toUpperCase(),
                    style: TEXT_SMALL_HEADLINE,
                  ),
                  const NextSong(),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => null,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
