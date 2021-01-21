import 'package:flutter/material.dart';
import 'package:productivity_app/models/times.dart';
import 'package:productivity_app/models/status.dart';

class Tasks {
  final String taskName;
  final Map<int, String> subTasks = {};
  final String status = Status().statuses[0];
  final int taskTime = 0;

  Tasks({this.taskName});
}
