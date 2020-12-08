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
      highlightColor: TURQUOISE,
      scaffoldBackgroundColor: DARK2,
      // https://api.flutter.dev/flutter/material/TextTheme-class.html
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w900,
          color: LIGHT1,
        ),
        headline2: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        headline3: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        headline4: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        headline5: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          color: Colors.white70,
        ),
        headline6: TextStyle(fontSize: 18.0),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      cardColor: DARK3,
    );

const TextStyle TEXT_HEADER = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

const TextStyle TEXT_BIG = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const TextStyle TEXT_SUBTITLE = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w300,
);

const TextStyle TEXT_SMALL_HEADLINE = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.normal,
);

const TextStyle TEXT_SMALL_SUBTITLE = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w300,
);