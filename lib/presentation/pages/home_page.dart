import 'package:flutter/material.dart';

import '../widgets/highlight.dart';
import '../widgets/shuffle_all_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print('HomePage.build');
    return SafeArea(
      child: Column(
        children: [
          const Highlight(),
          const ShuffleAllButton(
            verticalPad: 10.0,
            horizontalPad: 12.0,
          ),
        ],
      ),
    );
  }
}
