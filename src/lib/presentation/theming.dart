import 'package:flutter/material.dart';

const Color DARK1 = Color(0xff141216);
const Color DARK2 = Color(0xFF1e1b21);
const Color DARK25 = Color(0xFF242127);
const Color DARK3 = Color(0xff2e2a33); // 645375 // 241d2b
const Color DARK35 = Color(0xff3d3a42);
const Color DARK4 = Color(0xff56525b);
const Color LIGHT1 = Color(0xff913af1);
const Color LIGHT2 = Color(0xffac5bfb);

const Color RED = Colors.red;

const double HORIZONTAL_PADDING = 16.0;

ThemeData theme() => ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        primary: DARK2,
        secondary: LIGHT1,
        surface: DARK3,
        background: DARK2,
        error: RED,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white10, // only seen used in Switch so far
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      primaryColor: DARK1,
      primaryColorLight: DARK2,
      highlightColor: LIGHT1,
      scaffoldBackgroundColor: DARK2,
      cardColor: DARK3,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: LIGHT1,
          foregroundColor: Colors.white,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: LIGHT2),
      sliderTheme: const SliderThemeData(
        activeTrackColor: LIGHT2,
        thumbColor: DARK35,
        inactiveTrackColor: DARK4,
      ),
      // https://api.flutter.dev/flutter/material/TextTheme-class.html
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w900,
          color: LIGHT1,
        ),
        displayMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        headlineSmall: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          color: Colors.white70,
        ),
        titleLarge: TextStyle(fontSize: 18.0),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: LIGHT2,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20.0,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20.0,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
        foregroundColor: Colors.white,
      )),
      appBarTheme: const AppBarTheme(
        color: DARK1,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20.0,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: DARK1,
        selectedItemColor: LIGHT1,
        selectedLabelStyle: TextStyle(fontSize: 10.0),
        unselectedLabelStyle: TextStyle(fontSize: 10.0),
        elevation: 0.0,
      ),
      dividerTheme: const DividerThemeData(
        indent: HORIZONTAL_PADDING,
        endIndent: HORIZONTAL_PADDING,
        space: 0.0,
        color: Colors.white10,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.white30;
          }
          return DARK35;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return LIGHT1;
          } else if (states.contains(MaterialState.disabled)) {
            return Colors.white30;
          }
          return DARK4;
        }),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thickness: MaterialStateProperty.all(4.0),
        radius: const Radius.circular(2.0),
        thumbColor: MaterialStateProperty.all(Colors.white12),
        interactive: true,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.white,
      ),
      radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.white30;
        } else if (states.contains(MaterialState.selected)) {
          return LIGHT1;
        }
        return Colors.white;
      })),
    );

const TextStyle TEXT_HEADER = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w800,
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
  fontWeight: FontWeight.w200,
);

const TextStyle TEXT_SMALL_HEADLINE = TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.normal,
);

const TextStyle TEXT_SMALL_SUBTITLE = TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.w300,
);

extension TextStyleX on TextStyle {
  /// A method to underline a text with a customizable [distance] between the text
  /// and underline. The [color], [thickness] and [style] can be set
  /// as the decorations of a [TextStyle].
  TextStyle underlined({
    Color? underlineColor,
    Color? textColor,
    double distance = 1,
    double thickness = 1,
    TextDecorationStyle style = TextDecorationStyle.solid,
  }) {
    return copyWith(
      shadows: [
        Shadow(
          color: textColor ?? (color ?? Colors.black),
          offset: Offset(0, -distance),
        )
      ],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationThickness: thickness,
      decorationColor: underlineColor ?? color,
      decorationStyle: style,
    );
  }
}
