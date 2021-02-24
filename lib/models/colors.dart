import 'package:flutter/material.dart';

class ProjectColors {
  final int colorSelector;
  ProjectColors({this.colorSelector});

  final Map<String, int> colorList = {
    'LightRed': 0xFFFF8a80,
    'Red': 0xFFD50000,
    'Pink': 0xFFFF4081,
    'Maroon': 0xFF880E4F,
    'Purple': 0xFFE040FB,
    'DarkPurple': 0xFFAA00FF,
    'Indigo': 0xFF1A237E,
    'Blue': 0xFF2962FF,
    'LightBlue': 0xFF40C4FF,
    'Cyan': 0xFF18FFFF,
    'Teal': 0xFF1DE9B6,
    'Green': 0xFF00C853,
    'DarkGreen': 0xFF1B5E20,
    'LightGreen': 0xFF76FF03,
    'Yellow': 0xFFFFFF00,
    'Gold': 0xFFFFC400,
    'Orange': 0xFFFF9100,
    'DeepOrange': 0xFFFF3D00,
    'LightBrown': 0xFFA1887F,
    'DarkBrown': 0xFF4E342E,
    'Gray': 0xFF757575,
    'BlueGray': 0xFF607D8B,
  };

  Color getColor() {
    final Color color = Color(colorList[colorSelector]);
    return color;
  }
}
