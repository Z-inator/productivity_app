import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TimeService {
  final user;
  TimeService({this.user});

  // Collection Reference
  CollectionReference _getTimeEntryReference() {
    if (user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('timeEntry');
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
    return await _getTimeEntryReference()
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
  Future<void> updateTimeEntry(
      {String timeEntryID,
      String entryName,
      String projectName,
      DateTime startTime,
      DateTime endTime,
      int elapsedTime}) async {
    return await _getTimeEntryReference()
        .doc(timeEntryID)
        .update({
          'entryName': entryName,
          'projectName': projectName,
          'startTime': startTime,
          'endTime': endTime,
          'elapsedTime': elapsedTime
        })
        .then((value) => print('Time Entry Added'))
        .catchError((error) => print('Failed to add time entry: $error'));
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
  final user;
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
            print(document.id);
            return ListTile(
              leading: IconButton(
                  icon: Icon(Icons.plus_one),
                  onPressed: () {
                    TimeService(user: user).updateTimeEntry(
                        timeEntryID: docID, entryName: 'NewTimeNameUpdate');
                  }),
              title: Text(document.data()['entryName']),
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
