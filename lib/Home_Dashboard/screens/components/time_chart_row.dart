import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/pageview_row.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/project_pie_chart.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/recent_time_list.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/time_bar_chart.dart';
import 'package:productivity_app/Home_Dashboard/services/charts_and_graphs.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:provider/provider.dart';

class TimeChartRow extends StatelessWidget {
  const TimeChartRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimeGraphs timeGraphsState = Provider.of<TimeGraphs>(context);
    final List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    final List<DateTime> currentWeek = timeGraphsState.getCurrentWeek(DateTime.now());
    final List<TimeEntry> timeRangeEntries = timeGraphsState.getTimeRangeData(
        timeEntries, currentWeek[0], currentWeek[1]);
    final int totalTimeRangeTime =
        timeGraphsState.getTotalTimeRangeTime(timeRangeEntries);
    return timeRangeEntries == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              ListTile(
                title: Text('Recorded Time',
                    style: DynamicTheme.of(context).theme.textTheme.headline4),
                subtitle: Text(
                    DateTimeFunctions().timeToText(seconds: totalTimeRangeTime),
                    style: DynamicTheme.of(context).theme.textTheme.subtitle2),
                // TODO: implement a report screen
                // trailing: IconButton(
                //   icon: Icon(Icons.insights_rounded),
                //   tooltip: 'Reports',
                //   onPressed: () {},
                // ),
              ),
              Expanded(
                  child: timeRangeEntries.isEmpty
                      ? Center(
                          child: Text(
                              'Add Time Entries to this week to see Recorded Data'))
                      : PageViewRow(
                          pages: pages(timeRangeEntries, currentWeek[0],
                              currentWeek[1]))),
            ],
          );
  }

  List<Widget> pages(
      List<TimeEntry> timeEntries, DateTime startDay, DateTime endDay) {
    return [
      TimeBarChart(
          timeEntries: timeEntries, startDay: startDay, endDay: endDay),
      TimePieChart(timeEntries: timeEntries),
      RecentTimeList(timeEntries: timeEntries)
    ];
  }
}
