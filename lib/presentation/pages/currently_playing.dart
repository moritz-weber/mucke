import 'package:flutter/material.dart';
import 'package:mosh/presentation/theming.dart';

import '../widgets/album_art.dart';
import '../widgets/queue_card.dart';
import '../widgets/time_progress_indicator.dart';

class CurrentlyPlayingPage extends StatefulWidget {
  CurrentlyPlayingPage({Key key}) : super(key: key);

  @override
  _CurrentlyPlayingPageState createState() => _CurrentlyPlayingPageState();
}

class _CurrentlyPlayingPageState extends State<CurrentlyPlayingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  top: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.expand_more),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {},
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: AlbumArt(),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.link,
                          size: 20.0,
                        ),
                        Container(
                          width: 40,
                        ),
                        Icon(
                          Icons.favorite,
                          size: 20.0,
                          color: RASPBERRY,
                        ),
                        Container(
                          width: 40,
                        ),
                        Icon(
                          Icons.remove_circle_outline,
                          size: 20.0,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Container(
                      height: 24,
                    ),
                    TimeProgressIndicator(),
                    Container(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(Icons.repeat, size: 20.0),
                          Icon(Icons.skip_previous, size: 40.0),
                          Icon(
                            Icons.play_circle_filled,
                            size: 64.0,
                          ),
                          Icon(Icons.skip_next, size: 40.0),
                          Icon(Icons.shuffle, size: 20.0),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    Container(
                      height: 72,
                    ),
                  ],
                ),
              ),
              QueueCard(
                boxConstraints: constraints,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
