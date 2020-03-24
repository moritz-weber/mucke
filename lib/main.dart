import 'package:flutter/material.dart';

import 'presentation/pages/home.dart';
import 'presentation/pages/library.dart';
import 'presentation/pages/settings.dart';
import 'presentation/widgets/navbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        accentColor: Colors.amberAccent,
        // https://api.flutter.dev/flutter/material/TextTheme-class.html
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: RootPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class RootPage extends StatefulWidget {
  RootPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var navIndex = 0;

  final _pages = <Widget>[HomePage(), LibraryPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[navIndex],
      bottomNavigationBar: NavBar(
        onTap: (int index) {
          setState(() {
            navIndex = index;
          });
        },
        currentIndex: navIndex,
      ),
    );
  }
}
