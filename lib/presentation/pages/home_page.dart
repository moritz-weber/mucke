import 'package:flutter/material.dart';

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
    return Container(
      child: const Center(
        child: ShuffleAllButton(),
      ),
    );
  }
}
