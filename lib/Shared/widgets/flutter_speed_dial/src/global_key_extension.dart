import 'package:flutter/material.dart';

extension GlobalKeyExtension on GlobalKey {
  Rect get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null) {
      return renderObject.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }

  Offset get offset {
    final RenderBox renderObject = currentContext?.findRenderObject() as RenderBox;
    return renderObject.localToGlobal(Offset.zero);
  }
}