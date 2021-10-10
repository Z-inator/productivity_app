import 'package:flutter/material.dart';

import '../../../Shared/Shared.dart';

ThemeData buildThemeData(Color accentColor, bool isDark) {
  ThemeData base = isDark ? ThemeData.dark() : ThemeData.light();
  ColorScheme colorScheme = buildColorScheme(color: accentColor, isDark: isDark, base: base.colorScheme);
  TextTheme textTheme = buildTextTheme(base: base.primaryTextTheme, color: colorScheme.onSurface);
  return base.copyWith(
      colorScheme: colorScheme,

      bottomAppBarTheme: base.bottomAppBarTheme.copyWith(elevation: 16),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: colorScheme.surface,
        elevation: 8,
        foregroundColor: colorScheme.onSurface
      ),

      cardTheme: base.cardTheme.copyWith(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          elevation: 4),

      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide()),
        contentPadding: EdgeInsets.all(10),
      ),

      iconTheme: base.iconTheme.copyWith(
        color: colorScheme.onSurface
      ),
      primaryIconTheme: base.iconTheme.copyWith(
        color: colorScheme.onSurface
      ),

      // accentIconTheme: base.accentIconTheme.copyWith(color: colorScheme.onSurface),

      // unselectedWidgetColor: colorScheme.onBackground,

      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: colorScheme.secondaryVariant,
              onSurface: colorScheme.onSecondary,
              backgroundColor: colorScheme.background,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))))),
      buttonBarTheme: base.buttonBarTheme.copyWith(
          alignment: MainAxisAlignment.spaceAround
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
        primary: colorScheme.secondary,
        onPrimary: colorScheme.onSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))
        ),
      )),

      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme
      ),

      // timePickerTheme: base.timePickerTheme.copyWith(
      //   backgroundColor: colorScheme.background,
      //   dialHandColor: colorScheme.secondary,
      //   dialTextColor: colorScheme.onSurface,
      //   hourMinuteTextColor: colorScheme.onPrimary,
      //   hourMinuteColor: colorScheme.primary
      // ),

      tabBarTheme: base.tabBarTheme.copyWith(
        labelStyle: textTheme.subtitle1,
        labelColor: colorScheme.secondaryVariant,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2,
            color: colorScheme.secondaryVariant
          ),
          
        )
      ),

      primaryTextTheme: textTheme,
      textTheme: textTheme
      );
}

MaterialAccentColor getAccentColor({Color? color}) {
  return AppAccentColorList.singleWhere(
      (materialAccentColor) => materialAccentColor.value == color!.value);
}

ColorScheme buildColorScheme({Color? color, required bool isDark, ColorScheme? base}) {
  MaterialAccentColor currentColor = AppAccentColorList.singleWhere(
      (materialAccentColor) => materialAccentColor.value == color!.value);
  if (isDark) {
    return base!.copyWith(
        primary: currentColor.shade200,
        primaryVariant: currentColor.shade100,
        onPrimary: Colors.grey.shade900,
        secondary: currentColor.shade200,
        secondaryVariant: currentColor.shade100,
        onSecondary: Colors.grey.shade900,
        background: Colors.grey.shade900,
        onBackground: Colors.grey.shade500,
        surface: Colors.grey.shade800,
        onSurface: Colors.grey.shade100
        );
  }
  return base!.copyWith(
      primary: currentColor.shade700,
      primaryVariant: currentColor.shade200,
      onPrimary: Colors.grey.shade100,
      secondary: currentColor.shade400,
      secondaryVariant: currentColor.shade700,
      onSecondary: Colors.grey.shade900,
      background: Colors.grey.shade50,
      onBackground: Colors.grey.shade400,
      surface: Colors.white,
      onSurface: Colors.grey.shade600
  );
}

TextTheme buildTextTheme({required TextTheme base, Color? color}) {
  return base.copyWith(
      // button: base.button.copyWith(color: color),
      // caption: base.caption.copyWith(color: color),
      subtitle1: base.subtitle1!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: color
      ),
      subtitle2: base.subtitle2!.copyWith(
        fontSize: 16,
        color: color
      ),
      bodyText1: base.bodyText1!.copyWith(color: color),
      bodyText2: base.bodyText2!.copyWith(
        fontSize: 14,
        color: color
      ),
      headline4: base.headline4!.copyWith(
        fontSize: 34,
        color: color
      ),
      headline5: base.headline5!.copyWith(
        fontSize: 24,
        color: color
      ),
      headline6: base.headline6!.copyWith(
        fontSize: 20,
        color: color
      ),
      caption: base.caption!.copyWith(color: color));
}
