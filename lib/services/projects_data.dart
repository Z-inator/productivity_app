import 'dart:collection';

import 'package:productivity_app/models/projects.dart';

class ProjectData {
  List<Projects> _projects = [];

  UnmodifiableListView<Projects> get projects {
    return UnmodifiableListView(_projects);
  }

  int get projectCount {
    return _projects.length;
  }

  void addProject(String newProjectName, String newProjectColor) {
    final newProject =
        Projects(projectName: newProjectName, projectColor: newProjectColor);
    _projects.add(newProject);
  }

  void updateProject(
      Projects project, String updateProjectName, String updateProjectColor) {
    project.projectName = updateProjectName;
    project.projectColor = updateProjectColor;
  }

  void addTime(Projects project, int time) {
    project.projectTime += time;
  }

  void deleteProject(Projects project) {
    _projects.remove(project);
  }
}
