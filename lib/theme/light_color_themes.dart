import 'package:flutter/material.dart';

ColorScheme buildColorScheme({Color color, bool isDark, Color backGroundColor, ColorScheme base}) {
  if (isDark) {
    MaterialColor pickedColor = Colors.primaries.singleWhere((MaterialColor materialColor) => materialColor.shade200.value == color.value);
    return base.copyWith(primary: pickedColor, primaryVariant: pickedColor.shade50);
  }
  MaterialColor pickedColor = Colors.primaries.singleWhere((MaterialColor materialColor) => materialColor.shade500.value == color.value);
  return base.copyWith(primary: pickedColor, primaryVariant: pickedColor.shade700);
}
  // switch (colorString) {
  //   case 'Color(0xfff44336)':                                  // Red
  //     return base.copyWith(
  //       primary: Colors.red,
  //       primaryVariant: Colors.red.shade700,
  //       secondary: Colors.
  //     )
  //     ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: Colors.white,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xffe91E63)':                                 // Pink
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff9c27b0)':                                 // Purple
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff673AB7)':                                 // Deep Purple
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff3F51B5)':                                 // Indigo
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff2196f3)':                                 // Blue
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff03a9f4)':                                 // Light Blue
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff00bcd4)':                                 // Cyan
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff009688)':                                 // Teal
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff4caf50)':                                 // Green
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff8bc34a)':                                 // Light Green
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xffcddc39)':                                 // Lime
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xffffeb3b)':                                 // Yellow
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xffffc107)':                                 // Amber
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xffff9800)':                                 // Orange
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xffff5722)':                                 // Deep Orange
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff795548)':                                 // Brown
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   case 'Color(0xff607d8b)':                                 // Blue Gray
  //     return ColorScheme(
  //         primary: Colors.yellow,
  //         primaryVariant: Colors.yellow.shade700,
  //         secondary: Colors.deepOrange,
  //         secondaryVariant: Colors.deepOrange.shade700,
  //         surface: Colors.white,
  //         background: backGroundColor,
  //         error: Colors.red,
  //         onPrimary: Colors.blue,
  //         onSecondary: Colors.green,
  //         onSurface: Colors.pink,
  //         onBackground: Colors.indigo,
  //         onError: Colors.teal,
  //         brightness: Brightness.dark);
  //   default:
  // }