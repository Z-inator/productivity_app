import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key key}) : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> with AutomaticKeepAliveClientMixin {
    
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
                  List<Task> projectTasks = tasks.where((task) => task.project.id == project.id).toList();
                  return Container(
                      padding: EdgeInsets.all(10),
                      child: Card(
                          child: ProjectExpansionTile(project: project, numberOfTasks: projectTasks.length)
                      )
                  );
                }).toList());
  }
}
