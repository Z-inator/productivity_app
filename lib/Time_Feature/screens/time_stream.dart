import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/color_functions.dart';
import 'package:productivity_app/Shared/datetime_functions.dart';
import 'package:productivity_app/Shared/time_functions.dart';
import 'package:provider/provider.dart';
import 'daily_entry_future.dart';

// class TimeStream extends StatelessWidget {
//   const TimeStream({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<List<TimeEntry>>(
//       builder: (context, List<TimeEntry> timeEntries) {
//         return Text(timeEntries.first.elapsedTime)
//       }
//     );
//   }
// }

class TimeStream extends StatelessWidget {
  const TimeStream({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);

    return timeEntries == null
        ? Center(child: CircularProgressIndicator())
        : TimeStreamBody(timeEntries: timeEntries);
  }
}

class TimeStreamBody extends StatelessWidget {
  const TimeStreamBody({
    Key key,
    @required this.timeEntries,
  }) : super(key: key);

  final List<TimeEntry> timeEntries;

  @override
  Widget build(BuildContext context) {
    List<DateTime> days = [];
    timeEntries.sort((a, b) => a.endTime.compareTo(b.endTime));
    for (var i = 0; i < timeEntries.length; i++) {
      TimeEntry entry = timeEntries[i];
      if (!days.contains(entry.endTime)) {
        days.add(entry.endTime);
      }
    }
    return ListView(
        padding: EdgeInsets.only(bottom: 100),
        children: days.map((day) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              elevation: 5,
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
                  GroupByDay(
                    dailyEntries: timeEntries
                        .where((entry) => entry.endTime == day)
                        .toList(),
                  )
                ],
              ),
            ),
          );
        }).toList());
  }
}

class GroupByDay extends StatelessWidget {
  final List<TimeEntry> dailyEntries;
  const GroupByDay({Key key, this.dailyEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dailyEntries == null
        ? Center(child: CircularProgressIndicator())
        : ListBody(
            children: dailyEntries.map((entry) {
              return ListTile(
                leading: IconButton(
                    icon: Icon(Icons.play_arrow_rounded), onPressed: () {}),
                title: Text(entry.entryName),
                subtitle: Text(entry.project.projectName,
                    style: TextStyle(color: Color(entry.project.projectColor))),
                trailing: Text(entry.elapsedTime.toString()),
              );
            }).toList(),
          );
  }
}
