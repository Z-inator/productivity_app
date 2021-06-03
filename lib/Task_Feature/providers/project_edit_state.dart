import 'package:flutter/material.dart';

import '../../Task_Feature/Task_Feature.dart';
import '../../Shared/Shared.dart';

class ProjectEditState extends ChangeNotifier {
  Project newProject;
  final Project oldProject;

  ProjectEditState({this.oldProject}) {
    if (oldProject != null) {
      newProject = oldProject.copyProject();
    } else {
      newProject = Project();
    }
  }

  void updateProject(Project project) {
    newProject = project;
  }

  void updateProjectClient(String projectClient) {
    newProject.projectClient = projectClient;
    notifyListeners();
  }

  void updateProjectColor(int projectColor) {
    int index = AppColorList.indexWhere((color) => color.value == projectColor);
    newProject.projectColor = index;
    notifyListeners();
  }

  void updateProjectName(String projectName) {
    newProject.projectName = projectName;
    notifyListeners();
  }
}
