import 'package:flutter/material.dart';
import 'package:mosh/presentation/pages/currently_playing.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({Key key, @required this.onTap, @required this.currentIndex})
      : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: LinearProgressIndicator(
              value: 0.42,
            ),
            height: 2,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentlyPlayingPage()));
            },
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/twilight.jpg'),
                  height: 64.0,
                ),
                Container(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Guardians of Asgaard"),
                    Text(
                      "Amon Amarth",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white70,
                      ),
                    )
                  ],
                ),
                Spacer(),
                IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
                IconButton(icon: Icon(Icons.pause), onPressed: () {}),
                IconButton(icon: Icon(Icons.skip_next), onPressed: () {}),
              ],
            ),
          ),
          Container(
            color: Colors.grey[850],
            height: 1.0,
          ),
          BottomNavigationBar(
              backgroundColor: Colors.grey[900],
              currentIndex: widget.currentIndex,
              onTap: widget.onTap,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text("Home")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_music), title: Text("Library")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), title: Text("Settings")),
              ])
        ],
      ),
    );
  }
}
