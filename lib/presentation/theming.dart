import 'package:flutter/material.dart';

const Color DARK1 = Color(0xff090711);
const Color DARK2 = Color(0xff141216);
const Color DARK3 = Color(0xff242127); // 645375 // 241d2b
const Color LIGHT1 = Color(0xff913af1);
const Color LIGHT2 = Color(0xffac5bfb);

const double HORIZONTAL_PADDING = 16.0;

ThemeData theme() => ThemeData(
      colorScheme: const ColorScheme(
        primary: DARK2,
        primaryVariant: DARK1,
        secondary: LIGHT2,
        secondaryVariant: LIGHT1,
        surface: DARK3,
        background: DARK2,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      primaryColor: DARK1,
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: DARK2,
      highlightColor: LIGHT1,
      scaffoldBackgroundColor: DARK2,
      // cardColor: DARK3,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: LIGHT1,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: LIGHT2),
      sliderTheme: const SliderThemeData(activeTrackColor: LIGHT2, thumbColor: LIGHT2, inactiveTrackColor: Colors.white24),
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
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: LIGHT2,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      appBarTheme: const AppBarTheme(color: DARK1),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: DARK1,
        selectedItemColor: LIGHT1,
      ),
      dividerTheme: const DividerThemeData(
        indent: HORIZONTAL_PADDING,
        endIndent: HORIZONTAL_PADDING,
        space: 0.0,
      ),
    );

const TextStyle TEXT_HEADER = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const TextStyle TEXT_HEADER_S = TextStyle(
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
