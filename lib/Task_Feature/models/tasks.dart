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

  Task({taskID, taskName, project, status, dueDate, createDate})
      : taskID = taskID as String ?? '',
        taskName = taskName as String ?? '',
        project = project as Project ?? Project(),
        status = status as Status ?? Status(),
        dueDate = dueDate as DateTime ?? DateTime(0),
        createDate = createDate as DateTime ?? DateTime.now();

  factory Task.fromFirestore(
      DocumentSnapshot snapshot, Project project, Status status) {
    final Map data = snapshot.data();
    return Task(
        taskID: snapshot.id ?? '',
        taskName: data['taskName'] as String ?? '',
        project: project ?? Project(),
        status: status ?? Status(),
        dueDate: (data['dueDate'] as Timestamp).toDate() ?? DateTime(1),
        createDate:
            (data['createDate'] as Timestamp).toDate() ?? DateTime.now());
  }

  Map<String, dynamic> toFirestore() {
    return {
      'taskName': taskName,
      'projectName': project.projectName,
      'status': status.statusName,
      'dueDate': dueDate,
      'createDate': createDate,
    };
  }
}
