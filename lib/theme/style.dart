import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Color(0x8a000000)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[600],
        primary: Colors.white,

      )
    )
  );
}


// Radius for items (cards, modal sheets, etc) = 20
// 