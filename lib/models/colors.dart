import 'package:flutter/material.dart';

class ProjectColors {
  final Map<String, int> colorList = {
    'LightRed': 0xFFFF8a80,         // Light Red
    'Red': 0xFFD50000,              // Red
    'Pink': 0xFFFF4081,             // Pink
    'Maroon': 0xFF880E4F,           // Maroon
    'Purple': 0xFFE040FB,           // Purple
    'DarkPurple': 0xFFAA00FF,       // Dark Purple
    'Indigo': 0xFF1A237E,           // Indigo
    'Blue': 0xFF2962FF,             // Blue
    'LightBlue': 0xFF40C4FF,        // Light Blue
    'Cyan': 0xFF18FFFF,             // Cyan
    'Teal': 0xFF1DE9B6,             // Teal
    'Green': 0xFF00C853,            // Green
    'DarkGreen': 0xFF1B5E20,        // Dark Green
    'LightGreen': 0xFF76FF03,       // Light Green
    'Yellow': 0xFFFFFF00,           // Yellow
    'Gold': 0xFFFFC400,             // Gold
    'Orange': 0xFFFF9100,           // Orange
    'DeepOrange': 0xFFFF3D00,       // Deep Orange
    'LightBrown': 0xFFA1887F,       // Light Brown
    'DarkBrown': 0xFF4E342E,        // Dark Brown
    'Gray': 0xFF757575,             // Gray
    'BlueGray': 0xFF607D8B,         // Blue Gray
  };

  int getColor({int colorSelector}) {
    final int color = colorList[colorSelector];
    print('getColor running: $color');
    return color;
  }
}
