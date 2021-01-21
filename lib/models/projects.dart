import 'package:flutter/material.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/models/times.dart';

class Projects {
  final String projectName;
  // TODO double check what variable type this needs to be
  final String projectColor; 
  final int projectTime = 0;
  final Map<int, Tasks> taskList = {};

  Projects({this.projectName, this.projectColor});
}
