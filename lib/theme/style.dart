import 'package:flutter/material.dart';

// class Themes {
//   static const int LightTheme = 0;
//   static const int DarkTheme = 1;

//   themeCollection = ThemeCollection(
//     themes: {
//       Themes.LightTheme: ThemeData(),
//       Themes.DarkTheme: ThemeData()
//     }
//   )

//   ThemeData darkTheme = ThemeData();

//   ThemeData lightTheme = ThemeData();
// }


ThemeData appTheme() {
  final Color primaryColor = Colors.white;
  final Color accentColor = Colors.blue;
    return ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,

        // appBarTheme: AppBarTheme(
        //   iconTheme: IconThemeData(
        //     color: Color(0x8a000000)
        //   )
        // ),

        textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.grey[800]),
            subtitle2: TextStyle(color: Colors.white)),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: accentColor)),
          contentPadding: EdgeInsets.all(10),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          elevation: 4,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))))),
        buttonBarTheme:
            ButtonBarThemeData(alignment: MainAxisAlignment.spaceAround));
  }

