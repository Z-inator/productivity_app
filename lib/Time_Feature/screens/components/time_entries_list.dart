import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/grouped_time_entries.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TimeEntriesByDay extends StatelessWidget {
  final List<TimeEntry> timeEntries;
  List<Map<String, List<TimeEntry>>> entryMapList;
  TimeEntriesByDay({Key key, this.timeEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimeService timeService = Provider.of<TimeService>(context);
    entryMapList = timeService.getTimeEntriesByDay(timeEntries);
    return entryMapList == null
        ? Center(child: CircularProgressIndicator())
        : entryMapList.isEmpty
            ? Center(child: Text('Record time-tracked to view here.'))
            : ListView(
                padding: EdgeInsets.only(bottom: 100),
                children: entryMapList.map((Map<String, List<TimeEntry>> item) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ListTile(
                              title: Text(item.keys.single),
                              trailing: Text(
                                  timeService
                                      .getDailyRecordedTime(item.values.single),
                                  style: DynamicColorTheme.of(context)
                                      .data
                                      .textTheme
                                      .subtitle1)),
                          Divider(),
                          GroupedTimeEntries(timeEntries: item.values.single),
                        ],
                      ),
                    ),
                  );
                }).toList());
  }
}
