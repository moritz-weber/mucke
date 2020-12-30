import 'package:flutter/material.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Header(),
            const Highlight(),
            const ShuffleAllButton(
              verticalPad: 20.0,
              horizontalPad: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}
