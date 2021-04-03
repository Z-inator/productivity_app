import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';

class TimeEntry {
  String entryID;
  DateTime startTime;
  DateTime endTime;
  int elapsedTime;
  String entryName;
  Project project;

  TimeEntry(
      {this.entryID,
      this.entryName,
      this.project,
      this.startTime,
      this.endTime,
      this.elapsedTime});

  // TODO: Entertain the idea of converting the timeEntries to a filtered distinct list instead of subCollections
  factory TimeEntry.fromFirestore(DocumentSnapshot snapshot, Project project) {
    Map data = Map.from(snapshot.data());
    // int projectIndex = projects.indexWhere(
    //     (project) => project.projectName == data['projectName'].toString());
    // Project associatedProject = projects[projectIndex];
    return TimeEntry(
        entryID: snapshot.id ?? '',
        entryName: data['entryName'] as String ?? '',
        project: project ?? Project(),
        startTime: (data['startTime'] as Timestamp).toDate() ?? DateTime.now(),
        endTime: (data['endTime'] as Timestamp).toDate() ?? DateTime.now(),
        elapsedTime: (data['elapsedTime'] as int) ?? 0);
  }
}
