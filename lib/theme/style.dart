import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData buildLightTheme(Color accentColor, bool isDark) {
  ThemeData base = isDark ? ThemeData.dark() : ThemeData.light();
  Color primaryColor = isDark ? Colors.grey[850] : Colors.white;
  return base.copyWith(
      primaryColor: primaryColor,
      accentColor: accentColor,
      // textTheme: TextTheme(
      //     subtitle1: TextStyle(color: Colors.grey[800]),
      //     subtitle2: TextStyle(color: primaryColor)),
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

// class AppThemes {
//   static const lightTheme = 0;
//   static const darkTheme = 1;
// }

// class AppThemesData {

//   int accentColor = 4280902399;
//   ThemeCollection themeCollection =
//       ThemeCollection(fallbackTheme: ThemeData.light(), themes: {
//     AppThemes.lightTheme: ThemeData(
//         primaryColor: Colors.white,
//         accentColor: Color(accentColor),
//         textTheme: TextTheme(
//             subtitle1: TextStyle(color: Colors.grey[800]),
//             subtitle2: TextStyle(color: Colors.white)),
//         inputDecorationTheme: InputDecorationTheme(
//           focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Color(accentColor))),
//           contentPadding: EdgeInsets.all(10),
//         ),
//         cardTheme: CardTheme(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(25))),
//           elevation: 4,
//         ),
//         outlinedButtonTheme: OutlinedButtonThemeData(
//             style: OutlinedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25))))),
//         buttonBarTheme:
//             ButtonBarThemeData(alignment: MainAxisAlignment.spaceAround)),
//     AppThemes.darkTheme: ThemeData(
//         primaryColor: Colors.grey[900],
//         accentColor: Color(accentColor),
//         textTheme: TextTheme(
//             subtitle1: TextStyle(color: Colors.white),
//             subtitle2: TextStyle(color: Colors.white)),
//         inputDecorationTheme: InputDecorationTheme(
//           focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Color(accentColor))),
//           contentPadding: EdgeInsets.all(10),
//         ),
//         cardTheme: CardTheme(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(25))),
//           elevation: 4,
//         ),
//         outlinedButtonTheme: OutlinedButtonThemeData(
//             style: OutlinedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25))))),
//         buttonBarTheme:
//             ButtonBarThemeData(alignment: MainAxisAlignment.spaceAround))
//   });
// }

// class ThemeNotifier extends ChangeNotifier {
//   ThemeData currentTheme = lightTheme;

//   var preference;
//   int accentColor;
//   ThemeData lightTheme;
//   ThemeData darkTheme;
//   bool isDark;

//   ThemeNotifier({this.accentColor, this.isDark}) {
//     getPreferences();
//     updateAccentColor(accentColor);
//     setCurrentTheme(isDark);
//   }

//   Future getPreferences() async {
//     preference = await SharedPreferences.getInstance();
//   }

//   void updateAccentColor(int color) {
//     accentColor = color;
//     preference.setInt('accentColor', accentColor);
//     notifyListeners();
//   }

//   void setCurrentTheme(bool switchToDark) {
//     if (isDark) {
//       currentTheme = getDarkTheme();
//       preference.setBool('isDark', true);
//     } else {
//       currentTheme = getLightTheme();
//       preference.setBool('isDark', false);
//     }
//     notifyListeners();
//   }
// }

// ThemeData appTheme() {
//   final Color primaryColor = Colors.white;
//   final Color accentColor = Colors.blue;
//   return ThemeData(
//       primaryColor: primaryColor,
//       accentColor: accentColor,
//       textTheme: TextTheme(
//           subtitle1: TextStyle(color: Colors.grey[800]),
//           subtitle2: TextStyle(color: Colors.white)),
//       inputDecorationTheme: InputDecorationTheme(
//         focusedBorder:
//             UnderlineInputBorder(borderSide: BorderSide(color: accentColor)),
//         contentPadding: EdgeInsets.all(10),
//       ),
//       cardTheme: CardTheme(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(25))),
//         elevation: 4,
//       ),
//       outlinedButtonTheme: OutlinedButtonThemeData(
//           style: OutlinedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(25))))),
//       buttonBarTheme:
//           ButtonBarThemeData(alignment: MainAxisAlignment.spaceAround));
// }
