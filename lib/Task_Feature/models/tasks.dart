import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/subtasks.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:provider/provider.dart';

class Task {
  String taskID = '';
  String taskName = '';
  Project project = Project();
  Status status = Status();
  DateTime dueDate = DateTime.now();
  DateTime createDate = DateTime.now();

  Task(
      {this.taskID,
      this.taskName,
      this.project,
      this.status,
      this.dueDate,
      this.createDate});


  factory Task.fromFirestore(DocumentSnapshot snapshot, Project project, Status status) {
    final Map data = snapshot.data();
    return Task(
        taskID: snapshot.id ?? '',
        taskName: data['taskName'] as String ?? '',
        project: project?? Project(),
        status: status ?? Status(),
        dueDate: (data['dueDate'] as Timestamp).toDate() ?? DateTime(0),
        createDate:
            (data['createDate'] as Timestamp).toDate() ?? DateTime.now()
    );
  }
}
