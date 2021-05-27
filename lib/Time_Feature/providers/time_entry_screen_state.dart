import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';

class TimeEntryBodyState extends ChangeNotifier {
  TimeEntryBodyState({this.entries, this.projects}) {
    currentEntryList = entries;
  }

  List<Project> projects;
  List<TimeEntry> entries;
  List<TimeEntry> currentEntryList = [];
  Project currentProject;

  void changeEntryList(Project project) {
    if (project.id.isEmpty) {
      currentEntryList = entries;
      currentProject = null;
    } else {
      currentEntryList =
        entries.where((entry) => entry.project.id == project.id).toList();
    currentProject = project;
    }
    notifyListeners();
  }  
}
