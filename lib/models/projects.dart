import 'package:flutter/material.dart';
import 'package:productivity_app/models/tasks.dart';

class Projects {
  String projectName;
  // TODO double check what variable type this needs to be
  String projectColor;
  int projectTime = 0;
  List<Tasks> taskList = [];

  Projects({this.projectName, this.projectColor});
}