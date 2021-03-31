import 'package:flutter/material.dart';

ThemeData appTheme() {
  Color primaryColor = Colors.white;
  Color accentColor = Colors.blue;

  return ThemeData(
    primaryColor: primaryColor,
    accentColor: accentColor,
    
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Color(0x8a000000)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: accentColor)
      ),
      contentPadding: EdgeInsets.all(10),
    )

    
  );
}


// Radius for items (cards, modal sheets, etc) = 20
// 