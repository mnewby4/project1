import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    primaryColor: const Color.fromRGBO(84, 190, 123, 1),
    fontFamily: 'Verdana',
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 23,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 21,
      ),
    ),
  );
}
