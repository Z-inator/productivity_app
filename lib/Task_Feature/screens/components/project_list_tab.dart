import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_expansion_tile.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key key}) : super(key: key);

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
                  final List<Task> projectTasks = tasks
                      .where((task) => task.project.id == project.id)
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
