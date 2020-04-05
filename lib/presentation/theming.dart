import 'package:flutter/material.dart';

const Color RASPBERRY = Color(0xFFea0367);
const Color TURQUOISE = Color(0xFF30d8f3);
const Color CRAYOLA = Color(0xfffde189);
const Color PINEAPPLE = Color(0xff56365e);
const Color MIDNIGHT = Color(0xff622371);
const Color MIDDLE_RED_PURPLE = Color(0xff0f0127);

ThemeData theme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.amber,
      accentColor: Colors.amberAccent,
      // https://api.flutter.dev/flutter/material/TextTheme-class.html
      textTheme: const TextTheme(
        title: TextStyle(fontSize: 20.0),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
      ),
    );
