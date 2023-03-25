import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

import '../theming.dart';
import 'next_song.dart';

class CurrentlyPlayingHeader extends StatelessWidget {
  const CurrentlyPlayingHeader({
    Key? key,
    required this.onTap,
    required this.onMoreTap,
  }) : super(key: key);

  final Function onTap;
  final Function onMoreTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.expand_more_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onTap(context),
            child: Container(
              height: 56.0,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    L10n.of(context)!.nextUp.toUpperCase(),
                    style: TEXT_SMALL_HEADLINE,
                  ),
                  const NextSong(),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          onPressed: () => onMoreTap(context),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
