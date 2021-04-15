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
    final TimeService state = Provider.of<TimeService>(context);
    List<DateTime> days = state.getDays(context);
    return days == null 
        ? Center(child: CircularProgressIndicator())
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
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateTimeFunctions().dateTimeToTextDate(date: day)),
                            // TODO: implement total time for the day
                            Text(TimeFunctions().timeToText(
                                seconds: state.getRecordedTime(context, day)))
                          ],
                        ),
                      ),
                      Divider(),
                      GroupedTimeEntries(
                        timeEntries: state.filteredTimeEntries(context, day),
                      )
                    ],
                  ),
                ),
              );
            }).toList());
  }
}
