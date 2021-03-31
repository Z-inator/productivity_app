import 'package:flutter/material.dart';
import 'package:productivity_app/Time_Feature/screens/time_stream.dart';


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
