library flutter_speed_dial;

import 'package:flutter/material.dart';

import 'global_key_extension.dart';
import 'custom_hole_clipper.dart';

class BackgroundOverlay extends AnimatedWidget {
  final Color color;
  final double opacity;
  final GlobalKey dialKey;
  final LayerLink layerLink;

  const BackgroundOverlay({
    Key key,
    Animation<double> animation,
    this.dialKey,
    this.layerLink,
    this.color = Colors.white,
    this.opacity = 0.7,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Opacity(
      opacity: opacity * animation.value,
          child: ClipPath(
      clipper: InvertedClipper(
        width: dialKey.globalPaintBounds.size.width, 
        height: dialKey.globalPaintBounds.size.height,
        dy: dialKey.offset.dy,
        dx: dialKey.offset.dx),
        child: Container(
              color: color,
        ),
      ),
          
    );
  }
}