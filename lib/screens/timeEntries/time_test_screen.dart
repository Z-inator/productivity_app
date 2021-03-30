import 'package:flutter/material.dart';
import 'package:productivity_app/models/times.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:provider/provider.dart';

// class TimeStreamTest extends StatelessWidget {
//   const TimeStreamTest({Key key}) : super(key: key);

//   Future<List<TimeEntry>> getTimeEntries(List<TimeEntry> timeEntries) async {
//     List<DateTime> days = [];
//     days = timeEntries.forEach((entry) {})
//     for (var i = 0; i < timeEntries.length; i++) {
//       TimeEntry entry = timeEntries[i];
//       if (!days.contains(entry.endTime)) {
//         days.add(entry.endTime);
//       }
//     }
//     return days;
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);

//     return timeEntries == null
//         ? Center(child: CircularProgressIndicator())
//         : ListView(
//             padding: EdgeInsets.only(bottom: 100),
//             children: days.map((day) {
//               return Container(
//                 padding: EdgeInsets.all(10),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25))),
//                   elevation: 5,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(DateTimeFunctions().dateTimeToTextDate(
//                                 date:
//                                     day)), // TODO: implement total time for the day
//                           ],
//                         ),
//                       ),
//                       Divider(),
//                       GroupByDay(day: day)
//                     ],
//                   ),
//                 ),
//               );
//             }).toList());
//   }
// }

class TimeStreamTest extends StatelessWidget {
  const TimeStreamTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    timeEntries.sort((a, b) => a.endTime.compareTo(b.endTime));
    List<DateTime> days = [];

    for (var i = 0; i < timeEntries.length; i++) {
      TimeEntry entry = timeEntries[i];
      if (!days.contains(entry.endTime)) {
        days.add(entry.endTime);
      }
    }
    return timeEntries == null
        ? Center(child: CircularProgressIndicator())
        : ListView(
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
                subtitle: Text(entry.projectName),
                trailing: Text(entry.elapsedTime.toString()),
              );
            }).toList(),
          );
  }
}

// class GroupByDay extends StatelessWidget {
//   final List<TimeEntry> dailyEntries;

//   GroupByDay({this.dailyEntries});

//   @override
//   Widget build(BuildContext context) {
//     return dailyEntries == null
//         ? Center(child: CircularProgressIndicator())
//         : ListBody(
//             children: dailyEntries.map((entry) {
//               return ListTile(
//                 leading: IconButton(
//                     icon: Icon(Icons.play_arrow_rounded), onPressed: () {}),
//                 title: Text(entry.entryName),
//                 subtitle: Text(entry.projectName),
//                 // ProjectColors()
//                 //     .getProjectColoredText(context, entry.projectName),
//                 trailing: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                         '${DateTimeFunctions().dateTimeToTextTime(date: entry.startTime)} - ${DateTimeFunctions().dateTimeToTextTime(date: entry.endTime)}'),
//                     Text(entry.elapsedTime.toString())
//                   ],
//                 ),
//               );
//             }).toList(),
//           );
//   }
// }

// class GroupByDay extends StatelessWidget {
//   final DateTime day;
//   GroupByDay({Key key, this.day}) : super(key: key);

//   Future<List<TimeEntry>> filterByDate(
//       List<TimeEntry> timeEntries, DateTime date) async {
//     List<TimeEntry> dayEntries =
//         await timeEntries.where((entry) => entry.endTime == date).toList();
//     return dayEntries;
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
//     return timeEntries == null ? Center(child: CircularProgressIndicator())
//     : FutureBuilder(
//         future: filterByDate(timeEntries, day),
//         builder:
//             (BuildContext context, AsyncSnapshot<List<TimeEntry>> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Something went wrong');
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return ListBody(
//             children: snapshot.data.map((entry) {
//               return ListTile(
//                 leading: IconButton(
//                     icon: Icon(Icons.play_arrow_rounded), onPressed: () {}),
//                 title: Text(entry.entryName),
//                 subtitle: Text(entry.projectName),
//                 // ProjectColors().getProjectColoredText(context, entry.projectName),
//                 trailing: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                         '${DateTimeFunctions().dateTimeToTextTime(date: entry.startTime)} - ${DateTimeFunctions().dateTimeToTextTime(date: entry.endTime)}'),
//                     Text(TimeFunctions().timeToText(seconds: entry.elapsedTime))
//                   ],
//                 ),
//               );
//             }).toList(),
//           );
//         });
//   }
// }
