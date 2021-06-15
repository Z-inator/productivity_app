import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:provider/provider.dart';

import '../../../Time_Feature/Time_Feature.dart';

class TimeEntriesByDay extends StatelessWidget {
  final List<TimeEntry>? timeEntries;
  List<Map<String, List<TimeEntry>>>? entryMapList;
  TimeEntriesByDay({Key? key, this.timeEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    entryMapList = TimeService.getTimeEntriesByDay(timeEntries!);
    return entryMapList == null
        ? Center(child: CircularProgressIndicator())
        : entryMapList!.isEmpty
            ? Center(child: Text('Record time-tracked to view here.'))
            : ListView(
                children: entryMapList!.map((Map<String, List<TimeEntry>> item) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ListTile(
                              title: Text(item.keys.single),
                              trailing: Text(DateTimeFunctions().timeToText(seconds: TimeService
                                      .getDailyRecordedTime(item.values.single)),
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
