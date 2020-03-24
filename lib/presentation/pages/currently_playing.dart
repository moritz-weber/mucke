import 'package:flutter/material.dart';
import 'package:mosh/presentation/widgets/queue_card.dart';
import 'package:mosh/presentation/widgets/time_progress_indicator.dart';

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
          builder: (context, constraints) => Stack(children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
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
                  Expanded(
                    flex: 10,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Card(
                            elevation: 2.0,
                            child: Image.asset('assets/twilight.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Guardians of Asgaard",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Text("Twilight of the Thunder God"),
                  Text("Amon Amarth"),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                        size: 20.0,
                      ),
                      Container(
                        width: 32,
                      ),
                      Icon(
                        Icons.favorite,
                        size: 20.0,
                      ),
                      Container(
                        width: 32,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    height: 100,
                  ),
                ],
              ),
            ),
            QueueCard(
              boxConstraints: constraints,
            ),
          ]),
        ),
      ),
    );
  }
}
