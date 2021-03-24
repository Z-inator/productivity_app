import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.blue,
    
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Color(0x8a000000)),
    ),
  );
}


// Radius for items (cards, modal sheets, etc) = 20
// 