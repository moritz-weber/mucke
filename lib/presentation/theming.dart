import 'package:flutter/material.dart';

const Color RASPBERRY = Color(0xFFea0367);
const Color TURQUOISE = Color(0xFF30d8f3);
const Color CRAYOLA = Color(0xfffde189);
const Color PINEAPPLE = Color(0xff56365e);
const Color MIDNIGHT = Color(0xff622371);
const Color MIDDLE_RED_PURPLE = Color(0xff0f0127);

const Color DARK1 = Color(0xff0c1a20);
const Color DARK2 = Color(0xff0f2020);
const Color DARK3 = Color(0xff142a35);
const Color LIGHT1 = Color(0xff57af99);
const Color LIGHT2 = Color(0xfff28396);

ThemeData theme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: DARK1,
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: DARK2,
      accentColor: LIGHT1,
      scaffoldBackgroundColor: DARK2,
      // https://api.flutter.dev/flutter/material/TextTheme-class.html
      textTheme: const TextTheme(
        headline6: TextStyle(fontSize: 20.0),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      cardColor: DARK3,
    );
