import 'package:flutter/material.dart';

class BasicCard extends StatelessWidget {
  final Widget content;
  final double elevation;

  BasicCard({this.content, this.elevation});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      elevation: elevation,
      child: content,
    );
  }
}
