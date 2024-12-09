import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Colors.blue;
  static const Color accentColor = Colors.orange;
  static const Color backgroundColor = Colors.white;
  static const Color errorColor = Colors.red;

  // Text styles
  static const TextStyle headline1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // ThemeData for MaterialApp
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: const TextTheme(
        displayLarge: headline1,
        displayMedium: bodyText1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          textStyle: buttonText,
        ),
      ),
      colorScheme: const ColorScheme.light().copyWith(secondary: accentColor),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
        displayLarge: headline1,
        displayMedium: bodyText1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          textStyle: buttonText,
        ),
      ),
      colorScheme: const ColorScheme.dark().copyWith(secondary: accentColor),
    );
  }
}
