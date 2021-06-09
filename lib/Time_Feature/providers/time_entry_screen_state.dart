import 'package:flutter/material.dart';

import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class TimeEntryBodyState extends ChangeNotifier {
  Project? currentProject;

  void changeProject(Project? project) {
    if (project == null) {
      currentProject = null;
    } else {
    currentProject = project;
    }
    notifyListeners();
  }  
}
