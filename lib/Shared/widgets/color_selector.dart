import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  int matchColor;
  Function saveColor;
  List colorList;
  ColorSelector({required this.matchColor, required this.saveColor, required this.colorList});

  @override
  Widget build(BuildContext context) {
    bool isDark = DynamicColorTheme.of(context).isDark;
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: colorList.map((color) {
          return IconButton(
              icon: Icon(
                matchColor == (isDark ? color.shade200.value : color.value)
                    ? Icons.check_circle_rounded
                    : Icons.circle,
                color: isDark ? Color(color.shade200.value as int) : Color(color.value as int),
                size: 36,
              ),
              onPressed: () {
                saveColor(color.value);
              });
        }).toList()));
  }
  // Row(
  //     children: AppColorList.map((color) {
  //   print(Color(color));
  //   IconButton(
  //     icon: Icon(
  //         matchColor == color ? Icons.check_circle_rounded : Icons.circle,
  //         color: Color(color),
  //         size: 36),
  //     onPressed: () => saveColor(color),
  //   );
  // }).toList())
}
