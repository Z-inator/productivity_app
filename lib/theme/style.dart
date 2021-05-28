import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



ThemeData buildThemeData(Color accentColor, bool isDark) {
  ThemeData base = isDark ? ThemeData.dark() : ThemeData.light();
  Color primaryColor = isDark ? Colors.grey[800] : Colors.white;
  Color iconColor = isDark ? Colors.white : Colors.grey[600];
  Color navigationBarIconColor = isDark ? Colors.white : Colors.grey[800];
  Color primaryTextColor = isDark ? Colors.white : Colors.black;
  Color secondaryTextColor = isDark ? Colors.white : Colors.grey[800];
  return base.copyWith(
      primaryColor: primaryColor,
      accentColor: accentColor,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: accentColor)),
        contentPadding: EdgeInsets.all(10),
      ),
      iconTheme: base.iconTheme.copyWith(color: iconColor),
      primaryIconTheme: base.primaryIconTheme.copyWith(color: navigationBarIconColor),
      cardTheme: base.cardTheme.copyWith(
          color: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          elevation: 4),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))))),
      buttonBarTheme:
          ButtonBarThemeData(alignment: MainAxisAlignment.spaceAround),
      primaryTextTheme:
          buildTextTheme(base: base.primaryTextTheme, color: primaryTextColor),
      textTheme: buildTextTheme(base: base.textTheme, color: primaryTextColor));
}

TextTheme buildTextTheme({TextTheme base, Color color}) {
  return base.copyWith(
      // button: base.button.copyWith(color: color),
      // caption: base.caption.copyWith(color: color),
      subtitle1: base.subtitle1.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      subtitle2: base.subtitle1.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      bodyText1: base.bodyText1.copyWith(color: color),
      bodyText2: base.bodyText2.copyWith(
        fontSize: 14,
      ),
      headline4: base.headline4.copyWith(
        fontSize: 34,
      ),
      headline5: base.headline5.copyWith(
        fontSize: 24,
      ),
      headline6: base.headline6.copyWith(
        fontSize: 20,
      ));
}


