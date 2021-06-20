import 'package:flutter/material.dart';

import '../theming.dart';

class Highlight extends StatelessWidget {
  const Highlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    child: const Image(
                      image: AssetImage('assets/no_cover.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 23,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Album of the Day'.toUpperCase(),
                        style: TEXT_SMALL_HEADLINE,
                      ),
                      Container(height: 6.0),
                      Text(
                        'All Our Gods Have Abandoned Us',
                        style: Theme.of(context).textTheme.headline4,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text(
                        'Architects',
                        style: TEXT_SMALL_SUBTITLE,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.play_circle_fill_rounded,
                  size: 48.0,
                ),
                iconSize: 48.0,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
