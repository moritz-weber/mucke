import 'package:flutter/material.dart';

class TimeProgressIndicator extends StatefulWidget {
  TimeProgressIndicator({Key key}) : super(key: key);

  @override
  _TimeProgressIndicatorState createState() => _TimeProgressIndicatorState();
}

class _TimeProgressIndicatorState extends State<TimeProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Text("0:42"),
          Container(
            width: 10,
          ),
          Expanded(
              child: Container(
            child: LinearProgressIndicator(value: 0.42),
            height: 4.0,
          )),
          Container(
            width: 10,
          ),
          Text("3:42"),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
