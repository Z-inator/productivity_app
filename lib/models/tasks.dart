import 'package:flutter/material.dart';
import 'package:productivity_app/models/subtasks.dart';
import 'package:productivity_app/models/status.dart';

class Tasks {
  String taskID;
  String taskName;
  List<String> subtasks = [];
  String status = Status().statuses[0];
  int taskTime = 0;
  DateTime dueDate;

  Tasks({this.taskName});
}
