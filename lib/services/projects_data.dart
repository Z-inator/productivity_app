import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class AddProject extends StatelessWidget {
  final String projectName;
  final String projectColor;
  int projectTime = 0;

  AddProject({this.projectName, this.projectColor});

  @override
  Widget build(BuildContext context) {
    CollectionReference projects =
        FirebaseFirestore.instance.collection('projects');

    Future<void> addProject() {
      return projects
          .add({
            'projectName': projectName,
            'projectColor': projectColor,
            'projectTime': projectTime
          })
          .then((value) => print('Project Added'))
          .catchError((error) => print('Failed to add project: $error'));
    }

    return FlatButton(onPressed: addProject, child: Text('Add Project'));
  }
}
