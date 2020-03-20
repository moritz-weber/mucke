import 'package:flutter/material.dart';

class QueueCard extends StatefulWidget {
  QueueCard({Key key, this.boxConstraints}) : super(key: key);

  final BoxConstraints boxConstraints;

  @override
  _QueueCardState createState() => _QueueCardState();
}

class _QueueCardState extends State<QueueCard> {
  bool _first = true;
  double _height = 96.0;

  @override
  Widget build(BuildContext context) {

    return AnimatedPositioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: _height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _height = _first ? widget.boxConstraints.maxHeight : 96.0;
              _first = !_first;
            });
          },
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: <Widget>[
                      Icon(Icons.expand_less),
                      Container(
                        width: 4.0,
                      ),
                      Text(
                        "Als nächstes:",
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Container(
                    height: 6.0,
                  ),
                  Row(
                    children: [
                      Image(
                        image: AssetImage('assets/disease.jpg'),
                        height: 26.0,
                      ),
                      Container(
                        width: 10,
                      ),
                      Text("Fire ~ Beartooth", // ·
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                    ],
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
        ),
      ),
      duration: Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
    );
  }
}
