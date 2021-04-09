import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
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
    final CollectionReference ref = _getTimeEntryReference();
    return ref.snapshots().map((QuerySnapshot querySnapshot) =>
        querySnapshot.docs.map((QueryDocumentSnapshot queryDocument) {
          final Project project = projects[projects.indexWhere((project) =>
              project.projectName ==
              queryDocument.data()['projectName'].toString())];
          return TimeEntry.fromFirestore(queryDocument, project);
        }).toList());
  }

  Future<List<Project>> getProjects(BuildContext context) async {
    final List<Project> projects =
        await Provider.of<ProjectService>(context).streamProjects().first;
    return projects;
  }

  List<TimeEntry> sortTimeEntries(List<TimeEntry> timeEntries) {
    timeEntries.sort((a, b) => a.endTime.compareTo(b.endTime));
    return timeEntries;
  }

  List<TimeEntry> filteredTimeEntries(
      List<TimeEntry> timeEntries, DateTime day) {
    return timeEntries.where((entry) => entry.endTime == day).toList();
  }

  List<DateTime> getDays(List<TimeEntry> timeEntries) {
    final List<DateTime> days = [];
    for (var i = 0; i < timeEntries.length; i++) {
      final TimeEntry entry = timeEntries[i];
      print(entry.entryID);
      if (!days.contains(entry.endTime)) {
        days.add(entry.endTime);
      }
    }
    return days;
  }

  int getRecordedTime(List<TimeEntry> timeEntries, DateTime day) {
    int recordedTime = 0;
    final List<TimeEntry> entriesToCount = filteredTimeEntries(timeEntries, day);
    entriesToCount.forEach((entry) {
      recordedTime += entry.elapsedTime;
    });
    return recordedTime;
  }

  List<TimeEntry> getGroupedTimeEntriesByProject(List<TimeEntry> timeEntries, Project project) {
    return timeEntries
        .where((entry) => entry.project.projectID == project.projectID)
        .toList();
  }

  List<TimeEntry> getGroupedTimeEntriesByTask(List<TimeEntry> timeEntries, Task task) {
    return timeEntries
        .where((entry) => entry.entryName == task.taskName)
        .toList();
  }

  // Add Time Entry
  Future<void> addTimeEntry({Map addData}) async {
    return _getTimeEntryReference()
        .add(Map<String, dynamic>.from(addData))
        .then((value) => print('Time Entry Added'))
        .catchError((error) => print('Failed to add time entry: $error'));
  }

  Future<void> addTimeEntry2({String addToDate, Map addData}) async {
    final DocumentSnapshot documentSnapshot =
        await _getTimeEntryReference().doc(addToDate).get();
    if (!documentSnapshot.exists) {
      await _getTimeEntryReference().doc(addToDate).set({'numberOfEntries': 1});
    } else {
      final dynamic newNumberOfEntries =
          documentSnapshot.data()['numberOfEntries'] + 1;
      await _getTimeEntryReference()
          .doc(addToDate)
          .set({'numberOfEntries': newNumberOfEntries});
    }
    return _getTimeEntryReference()
        .doc(addToDate)
        .collection('dayEntries')
        .add(Map<String, dynamic>.from(addData))
        .then((value) => print('Time Entry Added'))
        .catchError((error) => print('Failed to add time entry: $error'));
  }

  // Update Time Entry
  Future<void> updateTimeEntry({String timeEntryID, Map updateData}) async {
    return _getTimeEntryReference()
        .doc(timeEntryID)
        .update(Map<String, dynamic>.from(updateData))
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
