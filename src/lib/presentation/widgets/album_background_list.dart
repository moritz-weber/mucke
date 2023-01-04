import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mucke/presentation/widgets/album_background.dart';

import '../state/audio_store.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Widget child;

  @override
  void initState() {
    super.initState();
    child = Container(
      child: const Center(
        child: Text(
          'Main',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(begin: Offset(1.2, 0), end: Offset(0, 0))
                .animate(animation),
            child: child,
          );
        },
        child: Dismissible(
          key: UniqueKey(),
          resizeDuration: null,
          onDismissed: _onHorizontalSwipe,
          direction: DismissDirection.horizontal,
          child: child,
        ),
      ),
    );
  }

  static final AudioStore audioStore = GetIt.I<AudioStore>();
  void _onHorizontalSwipe(DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      setState(() {
        child = AlbumBackground(song: TODO);
      });
    } else {
      setState(() {
        child = AlbumBackground(song: TODO);
      });
    }
  }
}
