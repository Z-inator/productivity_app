
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Home_Dashboard/Home_Dashboard.dart';
import '../../../Shared/Shared.dart';
import '../../../Time_Feature/Time_Feature.dart';

class TimeChartRow extends StatelessWidget {
  TimeChartRow({Key? key}) : super(key: key);

  List<Widget> pages(
      List<TimeEntry> timeEntries, DateTime? startDay, DateTime? endDay) {
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
    List<DateTime?> currentWeek = timeGraphsState.getCurrentWeek(DateTime.now());
    List<TimeEntry> timeRangeEntries = timeGraphsState.getTimeRangeData(
        timeEntries, currentWeek[0], currentWeek[1]);
    int totalTimeRangeTime =
        timeGraphsState.getTotalTimeRangeTime(timeRangeEntries);
    return timeRangeEntries == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              ListTile(
                title: Text('Recorded Time',
                    style:
                        DynamicColorTheme.of(context).data.textTheme.headline4),
                subtitle: Text(
                    DateTimeFunctions().timeToText(seconds: totalTimeRangeTime),
                    style:
                        DynamicColorTheme.of(context).data.textTheme.subtitle2),
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
}
