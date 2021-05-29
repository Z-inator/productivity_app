import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:provider/provider.dart';

class ColorSelector extends StatelessWidget {
  int matchColor;
  Function(int) saveColor;
  ColorSelector({this.matchColor, this.saveColor});

  @override
  Widget build(BuildContext context) {
    final List<MaterialColor> colorList = AppColors().colorList;
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: colorList.map((color) {
          return IconButton(
            icon: Icon(
              matchColor == color ? Icons.check_circle_rounded : Icons.circle,
              color: DynamicColorTheme.of(context).isDark ? color.shade200 : color,
              size: 36,
            ),
            onPressed: () => saveColor(color.value),
          );
        }).toList())
        // Row(
        //     children: AppColors().colorList.map((color) {
        //   print(Color(color));
        //   IconButton(
        //     icon: Icon(
        //         matchColor == color ? Icons.check_circle_rounded : Icons.circle,
        //         color: Color(color),
        //         size: 36),
        //     onPressed: () => saveColor(color),
        //   );
        // }).toList())
        );
  }
}
