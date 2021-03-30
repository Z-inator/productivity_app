import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/times.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/times_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TimeStreamTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<List<TimeEntry>>(
            stream: TimeService().streamTimeEntries(),
            builder:
                (BuildContext context, AsyncSnapshot<List<TimeEntry>> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              }
              return ListView(
                  // padding: EdgeInsets.only(bottom: 100),
                  children: snapshot.data.map((entry) {
                return ListTile(
                  leading: Text(entry.elapsedTime.toString()),
                  title: Text(entry.entryName),
                  subtitle: Text(entry.projectName),
                  // trailing:
                  //     Text('${document.data()['startTime']} - ${document.data()['endTime']}'),
                );
              }).toList());
            }));
  }
}

// class TimeStreamTest extends StatelessWidget {
//   const TimeStreamTest({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
//     print(timeEntries);
//     return ListView(
//       padding: EdgeInsets.only(bottom: 100),
//       children: timeEntries.map((entry) {
//         return Container(
//           padding: EdgeInsets.all(10),
//           child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(25))),
//               elevation: 5,
//               child: ListTile(
//                 title: Text(entry.entryName),
//                 subtitle: Text('${entry.startTime} - ${entry.endTime}'),
//                 trailing: Text(entry.projectName),
//               )),
//         );
//       }).toList(),
//     );
// List<DateTime> days;
// for (var i = 0; i < timeEntries.length; i++) {
//   TimeEntry entry = timeEntries[i];
//   if (!days.contains(entry.endTime)) {
//     days.add(entry.endTime);
//   }
// }

// return ListView.builder(
//   padding: EdgeInsets.only(bottom: 100),
//   itemCount: days.length,
//   itemBuilder: (context, index) {
//     DateTime day = days[index];
//     return Container(
//       padding: EdgeInsets.all(10),
//       child: Card(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(25))),
//         elevation: 5,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//               padding: EdgeInsets.all(20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(DateTimeFunctions().dateTimeToTextDate(
//                       date: day)), // TODO: implement total time for the day
//                 ],
//               ),
//             ),
//             Divider(),
//             GroupByDay(day: day)
//           ],
//         ),
//       ),
//     );
//   },
// );
//   }
// }

class GroupByDay extends StatelessWidget {
  final DateTime day;
  const GroupByDay({Key key, this.day}) : super(key: key);

  List<TimeEntry> filterByDay(List<TimeEntry> timeEntries, DateTime date) {
    return timeEntries.where((entry) => entry.endTime == date).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    return ListBody(
      children: filterByDay(timeEntries, day).map((entry) {
        return ListTile(
          leading: IconButton(
              icon: Icon(Icons.play_arrow_rounded), onPressed: () {}),
          title: Text(entry.entryName),
          subtitle:
              ProjectColors().getProjectColoredText(context, entry.projectName),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  '${DateTimeFunctions().dateTimeToTextTime(date: entry.startTime)} - ${DateTimeFunctions().dateTimeToTextTime(date: entry.endTime)}'),
              Text(TimeFunctions().timeToText(seconds: entry.elapsedTime))
            ],
          ),
        );
      }).toList(),
    );
  }
}
