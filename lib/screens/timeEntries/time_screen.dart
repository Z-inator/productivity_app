import 'package:flutter/material.dart';
import 'package:productivity_app/screens/timeEntries/components/time_stream.dart';
import 'package:productivity_app/screens/timeEntries/time_test_screen.dart';

class TimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: Colors.green,
          title: Text('title'),
          onTap: () {},
        ),
        Expanded(child: TimeStream())
      ],
    );
  }
}
