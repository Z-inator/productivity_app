import 'package:flutter/material.dart';

class ProjectColors {
  final List<int> colorList = [
    0xFFFF8a80,              // Light Red
    0xFFD50000,              // Red
    0xFFFF4081,              // Pink
    0xFF880E4F,              // Maroon
    0xFFE040FB,              // Purple
    0xFFAA00FF,              // Dark Purple
    0xFF1A237E,              // Indigo
    0xFF2962FF,              // Blue
    0xFF40C4FF,              // Light Blue
    0xFF18FFFF,              // Cyan
    0xFF1DE9B6,              // Teal
    0xFF00C853,              // Green
    0xFF1B5E20,              // Dark Green
    0xFF76FF03,              // Light Green
    0xFFFFFF00,              // Yellow
    0xFFFFC400,              // Gold
    0xFFFF9100,              // Orange
    0xFFFF3D00,              // Deep Orange
    0xFFA1887F,              // Light Brown
    0xFF4E342E,              // Dark Brown
    0xFF757575,              // Gray
    0xFF607D8B,              // Blue Gray
  ];

  Color getColor({int colorSelector}) {
    final Color color = Color(colorList[colorSelector]);
    print('getColor running: $color');
    return color;
  }
}
