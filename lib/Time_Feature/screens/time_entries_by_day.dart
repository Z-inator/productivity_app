import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/grouped_time_entries.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TimeEntriesByDay extends StatelessWidget {
  final List<TimeEntry> timeEntries;
  const TimeEntriesByDay({Key key, this.timeEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimeService timeService = Provider.of<TimeService>(context);

    List<DateTime> days = timeService.getDays(timeEntries);
    return days == null
        ? Center(child: CircularProgressIndicator())
        : days.isEmpty
            ? Center(child: Text('Record Time Worked to View Here.'))
            : ListView(
                padding: EdgeInsets.only(bottom: 100),
                children: days.map((day) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateTimeFunctions()
                                    .dateTimeToTextDate(date: day)),
                                Text(TimeFunctions().timeToText(
                                    seconds: timeService.getDailyRecordedTime(
                                        timeEntries, day)))
                              ],
                            ),
                          ),
                          GroupedTimeEntries(
                            timeEntries: timeService.filteredTimeEntries(
                                timeEntries, day),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList());
  }
}
