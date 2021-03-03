import 'package:flutter/material.dart';
import 'package:productivity_app/screens/timeEntries/components/test.dart';
import 'package:productivity_app/screens/timeEntries/components/time_log_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:productivity_app/screens/timeEntries/components/time_stream.dart';
import 'package:productivity_app/shared_components/base_framework.dart';

import 'components/time_dashboard.dart';

class TimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false, // Hides the setting drawer icon
              floating: true,
              snap: true,
              stretch: true,
              expandedHeight: 300.0,
              backgroundColor: Colors.grey[50],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: <StretchMode>[StretchMode.blurBackground],
                background: Container(
                    margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: TimeDashboard()),
              ),
              forceElevated: innerBoxIsScrolled,
              onStretchTrigger: () {
                return;
              },
            )
          ];
        },
        body: TimeStream()
    );
    // BaseFramework(
    //   dashboard: TimeDashboard(),
    //   content: TimeLogList(),
    // );
    // Column(
    //   mainAxisSize: MainAxisSize.max,
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: <Widget>[
    //     Flexible(
    //       flex: 1,
    //       fit: FlexFit.loose,
    //       child: TimeDashboard()
    //     ),
    //     Flexible(
    //       flex: 1,
    //       fit: FlexFit.loose,
    //       child: TimeLogList(),
    //     )
    //   ]
    // );
  }
}
