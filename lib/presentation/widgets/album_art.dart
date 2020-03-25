import 'package:flutter/material.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(0),
        child: Stack(
          children: [
            Image.asset('assets/twilight.jpg'),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0x00555555),
                        const Color(0x77333333),
                        const Color(0xCC111111),
                        const Color(0xEE000000)
                      ],
                      stops: [
                        0.0,
                        0.6,
                        0.8,
                        1.0
                      ]),
                ),
              ),
            ),
            Positioned(
              bottom: 8.0,
              left: 8.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Guardians of Asgaard",
                    style: Theme.of(context).textTheme.title,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Amon Amarth: ",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        TextSpan(
                          text: "Twilight of the Thunder God",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
