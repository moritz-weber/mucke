import 'package:flutter/material.dart';

import 'currently_playing_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;
  final Function(int) onTap;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CurrentlyPlayingBar(),
          Container(
            color: Theme.of(context).primaryColorLight,
            height: 1.0,
          ),
          BottomNavigationBar(
            currentIndex: widget.currentIndex,
            onTap: widget.onTap,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
