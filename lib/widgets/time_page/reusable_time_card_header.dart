import 'package:flutter/material.dart';

class TimeCardHeader extends StatelessWidget {
  TimeCardHeader({this.date, this.dateTime});

  final String date;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(date), 
        Text(dateTime)
      ],
    );
  }
}
