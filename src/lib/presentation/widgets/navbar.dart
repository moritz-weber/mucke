import 'package:flutter/material.dart';

import '../theming.dart';
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
      color: DARK1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CurrentlyPlayingBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: DARK2,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: NavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  height: 72.0,
                  selectedIndex: widget.currentIndex,
                  onDestinationSelected: widget.onTap,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_rounded),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.library_music_rounded),
                      label: 'Library',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.search_rounded),
                      label: 'Search',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
