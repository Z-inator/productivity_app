import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class TimeService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection Reference
  CollectionReference _getTimeEntryReference() {
    final User user = _auth.currentUser;
    if (user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('timeEntries');
    }
  }

  CollectionReference get timeEntries {
    return _getTimeEntryReference();
  }

  // Snapshot Conversion to Time Model and Stream
  Stream<List<TimeEntry>> streamTimeEntries(BuildContext context) {
    List<Project> projects;
    getProjects(context).then((projectList) => projects = projectList);
    List<Task> tasks;
    getTasks(context).then((taskList) => tasks = taskList);
    final CollectionReference ref = _getTimeEntryReference();
    return ref.orderBy('endTime', descending: true).snapshots().map(
        (QuerySnapshot querySnapshot) =>
            querySnapshot.docs.map((QueryDocumentSnapshot queryDocument) {
              final Project project = projects.firstWhere((project) =>
                  project.id == queryDocument.data()['project'].toString());
              final Task task = tasks.firstWhere(
                  (task) => task.id == queryDocument.data()['task'].toString());
              return TimeEntry.fromFirestore(queryDocument, project, task);
            }).toList());
  }

  Future<List<Project>> getProjects(BuildContext context) async {
    final List<Project> projects =
        await Provider.of<ProjectService>(context).streamProjects().first;
    return projects;
  }

  Future<List<Task>> getTasks(BuildContext context) async {
    final List<Task> tasks =
        await Provider.of<TaskService>(context).streamTasks(context).first;
    return tasks;
  }

  List<Map<String, List<TimeEntry>>> getTimeEntriesByDay(
      List<TimeEntry> entries) {
    List<Map<String, List<TimeEntry>>> entryMapList = [];
    List<DateTime> days = [];
    for (TimeEntry entry in entries) {
      DateTime tempDate =
          DateTime(entry.endTime.year, entry.endTime.month, entry.endTime.day);
      if (!days.contains(tempDate)) {
        days.add(tempDate);
      }
    }
    days.sort((a, b) => b.compareTo(a));
    for (DateTime day in days) {
      List<TimeEntry> tempEntries = entries
          .where((entry) =>
              entry.endTime.year == day.year &&
              entry.endTime.month == day.month &&
              entry.endTime.day == day.day)
          .toList();
      entryMapList.add(
          {DateTimeFunctions().dateTimeToTextDate(date: day): tempEntries});
    }
    return entryMapList;
  }

  String getDailyRecordedTime(List<TimeEntry> timeEntries) {
    int recordedTime = 0;
    for (TimeEntry entry in timeEntries) {
      recordedTime += entry.elapsedTime;
    }
    return DateTimeFunctions().timeToText(seconds: recordedTime);
  }

  List<TimeEntry> getTimeEntriesByProject(
      List<TimeEntry> timeEntries, Project project) {
    return timeEntries
        .where((entry) => entry.project.id == project.id)
        .toList();
  }

  List<TimeEntry> getTimeEntriesByTask(List<TimeEntry> timeEntries, Task task) {
    return timeEntries
        .where((entry) => entry.entryName == task.taskName)
        .toList();
  }

  // // Add Time Entry
  // Future<void> addTimeEntry({Map<String, dynamic> addData}) async {
  //   return _getTimeEntryReference()
  //       .add(addData)
  //       .then((value) => print('Time Entry Added'))
  //       .catchError((error) => print('Failed to add time entry: $error'));
  // }

  // // Update Time Entry
  // Future<void> updateTimeEntry(
  //     {String timeEntryID, Map<String, dynamic> updateData}) async {
  //   return _getTimeEntryReference()
  //       .doc(timeEntryID)
  //       .update(updateData)
  //       .then((value) => print('Time Entry Updated'))
  //       .catchError((error) => print('Failed to update time entry: $error'));
  // }

  // // Delete Time Entry
  // Future<void> deleteTimeEntry({String timeEntryID}) async {
  //   return _getTimeEntryReference()
  //       .doc(timeEntryID)
  //       .delete()
  //       .then((value) => print('Time Entry Deleted'))
  //       .catchError((error) => print('Failed to delete time entry: $error'));
  // }
}

// class TimeEntryStream extends StatelessWidget {
//   final User user;
//   TimeEntryStream({this.user});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: TimeService(user: user)
//             .timeEntries
//             .orderBy('endTime', descending: true)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Something went wrong');
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Text('Loading');
//           }
//           return ListView(
//             shrinkWrap: true,
//             children: snapshot.data.docs.map((DocumentSnapshot document) {
//               final String elapsedTime =
//                   document.data()['elapsedTime'].toString();
//               final String entryName = document.data()['entryName'].toString();
//               final DateTime endDate = document.data()['endTime'].toDate();
//               return ListTile(
//                 leading: IconButton(
//                     icon: Icon(Icons.play_arrow_rounded), onPressed: () {}),
//                 title: Text(entryName),
//                 subtitle: Text(elapsedTime.toString()),
//                 trailing: Text(
//                     '${endDate.month}/${endDate.day}/${endDate.year} - ${endDate.hour}:${endDate.minute}'),
//               );
//             }).toList(),
//           );
//         });
//   }
// }

// if (project != null && task == null) {
//   project.projectTime += time;
// } else if (project == null && task != null) {
//   task.taskTime += time;
// } else {
//   timeEntry.add(time);
// }

// void updateTime(int time) {
//   if (project != null && task == null) {
//     project.projectTime += time;
//   } else if (project == null && task != null) {
//     task.taskTime += time;
//   } else {
//     timeEntry.add(time);
//   }
// }

// void removeTime(int time) {
//   if (project != null && task == null) {
//     project.projectTime -= time;
//   } else if (project == null && task != null) {
//     task.taskTime -= time;
//   } else {
//     timeEntry.remove(time);
//   }
// }
