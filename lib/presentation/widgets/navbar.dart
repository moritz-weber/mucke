import 'package:flutter/material.dart';

import 'currently_playing_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key key, @required this.onTap, @required this.currentIndex})
      : super(key: key);

  final int currentIndex;
  final Function(int) onTap;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final TextStyle _optionTextStyle = TextStyle(
    fontWeight: FontWeight.w300,
  );

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
            backgroundColor: Theme.of(context).primaryColor,
            currentIndex: widget.currentIndex,
            onTap: widget.onTap,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: _optionTextStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music),
                title: Text(
                  'Library',
                  style: _optionTextStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: _optionTextStyle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
