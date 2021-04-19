import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';

class TimeEntry {
  String entryID;
  DateTime startTime;
  DateTime endTime;
  int elapsedTime;
  String entryName;
  Project project;
  Task task;

  TimeEntry({entryID, entryName, project, task, startTime, endTime, elapsedTime})
      : entryID = entryID as String ?? '',
        entryName = entryName as String ?? '',
        project = project as Project ?? Project(),
        startTime = startTime as DateTime ?? DateTime.now(),
        endTime = endTime as DateTime ?? DateTime.now().add(Duration(hours: 1)),
        elapsedTime = elapsedTime as int ?? 0;

  factory TimeEntry.fromFirestore(
    DocumentSnapshot snapshot,
    Project project,
    Task task
  ) {
    final Map data = Map.from(snapshot.data());
    return TimeEntry(
        entryID: snapshot.id ?? '',
        entryName: data['entryName'] as String ?? '',
        project: project ?? Project(),
        task: task ?? Task(),
        startTime: (data['startTime'] as Timestamp).toDate() ?? DateTime.now(),
        endTime: (data['endTime'] as Timestamp).toDate() ?? DateTime.now(),
        elapsedTime: (data['startTime'] as Timestamp)
                .toDate()
                .compareTo((data['endTime'] as Timestamp).toDate()) ??
            0);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'entryName': entryName,
      'entryProject': project.projectID,
      'entryTask': task.taskID,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
