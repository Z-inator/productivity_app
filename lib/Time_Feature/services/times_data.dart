import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

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
                  project.projectID == queryDocument.data()['project'].toString());
              final Task task = tasks.firstWhere((task) =>
                  task.taskID == queryDocument.data()['task'].toString());
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

  List<TimeEntry> filteredTimeEntries(
      List<TimeEntry> timeEntries, DateTime day) {
    return timeEntries.where((entry) => entry.endTime == day).toList();
  }

  List<DateTime> getDays(List<TimeEntry> timeEntries) {
    final List<DateTime> days = [];
    for (var i = 0; i < timeEntries.length; i++) {
      final TimeEntry entry = timeEntries[i];
      if (!days.contains(entry.endTime)) {
        days.add(entry.endTime);
      }
    }
    days.sort((a, b) => b.compareTo(a));
    return days;
  }

  int getRecordedTime(List<TimeEntry> timeEntries, DateTime day) {
    int recordedTime = 0;
    List<TimeEntry> dailyEntries;
    dailyEntries =
        timeEntries.where((entry) => entry.endTime.day == day.day).toList();
    dailyEntries.forEach((entry) {
      recordedTime += entry.elapsedTime;
    });
    return recordedTime;
  }

  List<TimeEntry> getTimeEntriesByProject(
      List<TimeEntry> timeEntries, Project project) {
    return timeEntries
        .where((entry) => entry.project.projectID == project.projectID)
        .toList();
  }

  List<TimeEntry> getTimeEntriesByTask(List<TimeEntry> timeEntries, Task task) {
    return timeEntries
        .where((entry) => entry.entryName == task.taskName)
        .toList();
  }

  List<int> getWeekTimeData(
      List<TimeEntry> timeEntries, DateTime referenceDay) {
    DateTime monday;
    DateTime sunday;
    List<DateTime> days;
    List<int> recordedDailyTime;

    for (var day = 0; day < 7; day++) {
      DateTime decreaseTemp = referenceDay.subtract(Duration(days: day));
      if (decreaseTemp.weekday == 1) {
        monday =
            DateTime(decreaseTemp.year, decreaseTemp.month, decreaseTemp.day);
      }
      DateTime increaseTemp = referenceDay.add(Duration(days: day));
      if (increaseTemp.weekday == 7) {
        sunday =
            DateTime(increaseTemp.year, increaseTemp.month, increaseTemp.day);
      }
    }
    List<TimeEntry> weeksData = timeEntries
        .where((entry) =>
            entry.endTime.isAfter(monday.subtract(Duration(days: 1))) &&
            entry.endTime.isBefore(sunday.add(Duration(days: 1))))
        .toList();
    days = getDays(weeksData);
    days.forEach((day) {
      int temp = getRecordedTime(weeksData, day);
      recordedDailyTime.add(temp);
    });
    print(recordedDailyTime.length);
    return recordedDailyTime;
  }

  // Add Time Entry
  Future<void> addTimeEntry({Map<String, dynamic> addData}) async {
    return _getTimeEntryReference()
        .add(addData)
        .then((value) => print('Time Entry Added'))
        .catchError((error) => print('Failed to add time entry: $error'));
  }

  // Update Time Entry
  Future<void> updateTimeEntry(
      {String timeEntryID, Map<String, dynamic> updateData}) async {
    return _getTimeEntryReference()
        .doc(timeEntryID)
        .update(updateData)
        .then((value) => print('Time Entry Updated'))
        .catchError((error) => print('Failed to update time entry: $error'));
  }

  // Delete Time Entry
  Future<void> deleteTimeEntry({String timeEntryID}) async {
    return _getTimeEntryReference()
        .doc(timeEntryID)
        .delete()
        .then((value) => print('Time Entry Deleted'))
        .catchError((error) => print('Failed to delete time entry: $error'));
  }
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
