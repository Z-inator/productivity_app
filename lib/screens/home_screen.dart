import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/widgets/time_log_list_widget.dart';
import 'package:productivity_app/widgets/home_page_dashboard_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 1, 
            fit: FlexFit.loose, 
            child: DashboardCard()
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Scrollbar(
              child: ListView(
                children: <Widget>[
                  TimeLogList(),
                  TimeLogList(),
                  TimeLogList(),
                  TimeLogList(),
                ],
              ),
            )
          )

        ]);
  }
}
