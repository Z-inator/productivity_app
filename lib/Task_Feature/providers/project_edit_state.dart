import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';

class ProjectEditState with ChangeNotifier {
  Project newProject;

  void addProject() {
    newProject = Project();
    notifyListeners();
  }

  void updateProject(Project project) {
    newProject = project;
    notifyListeners();
  }

  void updateProjectName(String projectName) {
    newProject.projectName = projectName;
    notifyListeners();
  }

  void updateProjectColor(int projectColor) {
    newProject.projectColor = projectColor;
    notifyListeners();
  }

  void updateProjectClient(String projectClient) {
    newProject.projectClient = projectClient;
    notifyListeners();
  }
}
