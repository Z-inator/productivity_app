import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Task_Feature/Task_Feature.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final List<Project> projects = Provider.of<List<Project>>(context);
    final List<Task> tasks = Provider.of<List<Task>>(context);
    return projects == null
        ? Center(child: CircularProgressIndicator())
        : projects.isEmpty
            ? Center(child: Text('Add Projects to see them listed here'))
            : ListView(
                padding: EdgeInsets.only(bottom: 100),
                children: projects.map((project) {
                  List<Task> projectTasks = tasks
                      .where((task) => task.project!.id == project.id)
                      .toList();
                  return Container(
                      padding: EdgeInsets.all(10),
                      child: Card(
                          child: ProjectExpansionTile(
                              project: project,
                              numberOfTasks: projectTasks.length)));
                }).toList());
  }
}
