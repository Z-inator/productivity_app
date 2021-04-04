import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/grouped_time_entries.dart';
import 'package:provider/provider.dart';

class TimeEntriesByDay extends StatelessWidget {
  final List<TimeEntry> associatedEntries;
  const TimeEntriesByDay({Key key, this.associatedEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TimeEntry> timeEntries =
        associatedEntries ?? Provider.of<List<TimeEntry>>(context);
    return timeEntries == null
        ? Center(child: CircularProgressIndicator())
        : TimeEntriesByDayBody(timeEntries: timeEntries);
  }
}

class TimeEntriesByDayBody extends StatelessWidget {
  const TimeEntriesByDayBody({Key key, this.timeEntries}) : super(key: key);

  final List<TimeEntry> timeEntries;

  List<TimeEntry> filteredTimeEntries(
      List<TimeEntry> timeEntries, DateTime day) {
    return timeEntries.where((entry) => entry.endTime == day).toList();
  }

  List<DateTime> getDays(List<TimeEntry> timeEntries) {
    List<DateTime> days = [];
    for (var i = 0; i < timeEntries.length; i++) {
      TimeEntry entry = timeEntries[i];
      print(entry.entryID);
      if (!days.contains(entry.endTime)) {
        days.add(entry.endTime);
      }
    }
    // print(days);
    return days;
  }

  @override
  Widget build(BuildContext context) {
    timeEntries.sort((a, b) => a.endTime.compareTo(b.endTime));
    print(timeEntries.first.entryID);
    return ListView(
        padding: EdgeInsets.only(bottom: 100),
        children: getDays(timeEntries).map((day) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateTimeFunctions().dateTimeToTextDate(
                            date:
                                day)), // TODO: implement total time for the day
                      ],
                    ),
                  ),
                  Divider(),
                  GroupedTimeEntries(
                    timeEntries: filteredTimeEntries(timeEntries, day),
                  )
                ],
              ),
            ),
          );
        }).toList());
  }
}
