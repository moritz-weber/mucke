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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: Text(
                    'mucke',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
            ],
          ),
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
