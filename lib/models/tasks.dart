import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/subtasks.dart';
import 'package:productivity_app/models/status.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';

class Task {
  String taskID;
  String taskName;
  String projectName;
  String status;
  int taskTime;
  DateTime dueDate;
  // List<String> subtasks = [];

  Task(
      {this.taskID,
      this.taskName,
      this.projectName,
      this.status,
      this.taskTime,
      this.dueDate});

  factory Task.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Task(
      taskID: snapshot.id,
      taskName: data['taskName'].toString() ?? '',
      projectName: data['projectName'].toString() ?? '',
      status: data['status'].toString() ?? '',
      taskTime: data['taskTime'] ?? 0,
      dueDate: DateTimeFunctions().timeStampToDateTime(date: data['dueDate']) ?? DateTime.now()
    );
  }
}
