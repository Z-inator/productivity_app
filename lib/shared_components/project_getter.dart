import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/subtasks.dart';
import 'package:productivity_app/models/status.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:provider/provider.dart';

class GetProject extends StatelessWidget {
  final String projectName;
  const GetProject({Key key, this.projectName}) : super(key: key);

  Future<Project> getProjectModel(
      List<Project> projects, String projectName) async {
    Project project = await projects
        .firstWhere((project) => project.projectName == projectName);
    return project;
  }

  @override
  Widget build(BuildContext context) {
    List<Project> projects = Provider.of<List<Project>>(context);
    return FutureBuilder(
      future: getProjectModel(projects, projectName),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return;
      },
    );
  }
}
