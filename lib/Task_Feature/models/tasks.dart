import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/subtasks.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Shared/datetime_functions.dart';
import 'package:provider/provider.dart';

class Task {
  String taskID = '';
  String taskName = 'Default Name';
  Project project = Project();
  Status status = Status();
  int taskTime = 0;
  DateTime dueDate = DateTime(1);
  DateTime createDate = DateTime.now();
  // List<String> subtasks = [];

  Task(
      {this.taskID,
      this.taskName,
      this.project,
      this.status,
      this.taskTime,
      this.dueDate,
      this.createDate});

  // Future<List<Task>> getTasks(DocumentSnapshot snapshot) async {
  //   Map data = snapshot.data();

  // }

  factory Task.fromFirestore(DocumentSnapshot snapshot, List<Project> projects,
      List<Status> statuses) {
    Map data = snapshot.data();
    int projectIndex = projects.indexWhere(
        (project) => project.projectName == data['projectName'].toString());
    Project associatedProject = projects[projectIndex];
    int statusIndex = statuses
        .indexWhere((status) => status.statusName == data['status'].toString());
    Status status = statuses[statusIndex];
    return Task(
        taskID: snapshot.id ?? '',
        taskName: data['taskName'] as String ?? '',
        project: associatedProject ?? Project(),
        status: status ?? Status(),
        taskTime: data['taskTime'] as int ?? 0,
        dueDate: (data['dueDate'] as Timestamp).toDate() ?? DateTime(1),
        createDate:
            (data['createDate'] as Timestamp).toDate() ?? DateTime.now()
    );
  }
}
