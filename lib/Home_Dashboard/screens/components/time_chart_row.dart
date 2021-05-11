import 'dart:math';

import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/project_pie_chart.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/recent_time_list.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/time_bar_chart.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/pageview_position_dots.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/pageview_row.dart';
import 'package:productivity_app/Home_Dashboard/services/charts_and_graphs.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/screens/project_screen.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TimeChartRow extends StatelessWidget {
  TimeChartRow({Key key}) : super(key: key);

  List<Widget> pages(
      List<TimeEntry> timeEntries, DateTime startDay, DateTime endDay) {
    return [
      TimeBarChart(
          timeEntries: timeEntries, startDay: startDay, endDay: endDay),
      TimePieChart(timeEntries: timeEntries),
      RecentTimeList(timeEntries: timeEntries)
    ];
  }

  @override
  Widget build(BuildContext context) {
    TimeGraphs timeGraphsState = Provider.of<TimeGraphs>(context);
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    List<DateTime> currentWeek = timeGraphsState.getCurrentWeek(DateTime.now());
    List<TimeEntry> timeRangeEntries = timeGraphsState.getTimeRangeData(
        timeEntries, currentWeek[0], currentWeek[1]);
    int totalTimeRangeTime = timeGraphsState.getTotalTimeRangeTime(timeEntries);
    return timeRangeEntries == null
        ? Center(child: CircularProgressIndicator())
        : timeRangeEntries.isEmpty
            ? Center(
                child:
                    Text('Add Time Entries to this week to see Recorded Data'))
            : Column(
                children: [
                  ListTile(
                    title: Text('Recorded Time',
                        style: DynamicColorTheme.of(context)
                            .data
                            .textTheme
                            .headline5),
                    subtitle: Text(TimeFunctions()
                        .timeToText(seconds: totalTimeRangeTime)),
                    // TODO: implement a report screen
                    // trailing: IconButton(
                    //   icon: Icon(Icons.insights_rounded),
                    //   tooltip: 'Reports',
                    //   onPressed: () {},
                    // ),
                  ),
                  Expanded(
                      child: PageViewRow(
                          pages: pages(timeRangeEntries, currentWeek[0],
                              currentWeek[1]))),
                ],
              );
  }
}
