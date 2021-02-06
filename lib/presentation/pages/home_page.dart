import 'package:flutter/material.dart';

import '../theming.dart';
import '../widgets/header.dart';
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
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: HORIZONTAL_PADDING),
            child: Header(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
            child: Column(
              children: const [
                Highlight(),
                ShuffleAllButton(
                  verticalPad: 20.0,
                  horizontalPad: 0.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
