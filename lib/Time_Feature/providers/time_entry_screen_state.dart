import 'package:flutter/material.dart';

import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class TimeEntryBodyState extends ChangeNotifier {
  TimeEntryBodyState({this.entries, this.projects}) {
    currentEntryList = entries;
  }

  List<Project>? projects;
  List<TimeEntry>? entries;
  List<TimeEntry>? currentEntryList = [];
  Project? currentProject;

  void changeEntryList(Project? project) {
    if (project == null) {
      currentEntryList = entries;
      currentProject = null;
    } else {
      currentEntryList =
        entries!.where((entry) => entry.project!.id == project.id).toList();
    currentProject = project;
    }
    notifyListeners();
  }  
}
