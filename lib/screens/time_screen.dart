import 'package:flutter/material.dart';
import 'package:productivity_app/widgets/time_page/reusable_time_log_row.dart';
import 'package:productivity_app/widgets/time_page/reusable_time_card_header.dart';
import 'package:productivity_app/widgets/time_page/time_log_list.dart';

class TimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('data'),
              ]
            ),
          )
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Scrollbar(
            child: TimeLogList()
          ),
        )
      ]
    );
  }
}

