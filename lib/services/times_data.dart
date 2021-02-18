import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/components/time_to_text.dart';

class TimeService {
  final User user;
  TimeService({this.user});

  // Collection Reference
  CollectionReference _getTimeEntryReference() {
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

  // Add Time Entry
  Future<void> addTimeEntry(
      {String entryName,
      String projectName,
      DateTime startTime,
      DateTime endTime,
      int elapsedTime}) async {
    return _getTimeEntryReference()
        .add({
          'entryName': entryName,
          'projectName': projectName,
          'startTime': startTime,
          'endTime': endTime,
          'elapsedTime': elapsedTime
        })
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

class TimeEntryStream extends StatelessWidget {
  final User user;
  TimeEntryStream({this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TimeService(user: user).timeEntries.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            final String docID = document.id;
            final String elapsedTime = document.data()['elapsedTime'].toString();
            // final String hoursStr =
            //     ((elapsedTime / (60 * 60) % 60).floor().toString().padLeft(2, '0'));
            // final String minutesStr =
            //     ((elapsedTime / 60) % 60).floor().toString().padLeft(2, '0');
            // final String secondsStr =
            //     (elapsedTime % 60).floor().toString().padLeft(2, '0');
            print(document.id);
            return ListTile(
              leading: IconButton(
                  icon: Icon(Icons.plus_one),
                  onPressed: () {
                    TimeService(user: user).updateTimeEntry(timeEntryID: docID, updateData: {
                      'entryName': 'New Entry Name',
                      'elapsedTime': 200
                    });
                  }),
              title: Text(document.data()['entryName'].toString()),
              // subtitle: Text('$hoursStr:$minutesStr:$secondsStr'),
              subtitle: Text(elapsedTime.toString()),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    TimeService(user: user).deleteTimeEntry(timeEntryID: docID);
                  }),
            );
          }).toList(),
        );
      },
    );
  }
}

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
