import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/subtasks.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:provider/provider.dart';

class Task {
  String taskID;
  String taskName;
  Project project;
  Status status;
  DateTime dueDate;
  DateTime createDate;

  Task(
      {String taskID,
      String taskName,
      Project project,
      Status status,
      DateTime dueDate,
      DateTime createDate})
      : taskID = taskID ?? '',
        taskName = taskName ?? '',
        project = project ?? Project(),
        status = status ?? Status(),
        dueDate = dueDate ?? DateTime(0001, 01, 01, 0, 0, 0, 0, 555),
        createDate = createDate ?? DateTime.now();

  factory Task.fromFirestore(
      DocumentSnapshot snapshot, Project project, Status status) {
    final Map data = snapshot.data();
    return Task(
        taskID: snapshot.id ?? '',
        taskName: data['taskName'] as String ?? '',
        project: project ?? Project(),
        status: status ?? Status(),
        dueDate: (data['dueDate'] as Timestamp).toDate() ??
            DateTime(0001, 01, 01, 01, 0, 0, 0, 555),
        createDate:
            (data['createDate'] as Timestamp).toDate() ?? DateTime.now());
  }

  Map<String, dynamic> toFirestore() {
    return {
      'taskName': taskName,
      'project': project.projectID,
      'status': status.statusID,
      'dueDate': dueDate,
      'createDate': createDate,};
  }
}
