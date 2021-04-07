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

class ProjectStream extends StatelessWidget {
  const ProjectStream({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Project> projects = Provider.of<List<Project>>(context) ?? [];
    List<Task> tasks = Provider.of<List<Task>>(context);
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    return projects == null
        ? Center(child: CircularProgressIndicator())
        : ListView(
            padding: EdgeInsets.only(bottom: 100),
            children: projects.map((project) {
              return Container(
                  padding: EdgeInsets.all(10),
                  child: Card(
                      child: ProjectExpansionTile(
                          project: project,
                          tasks: Provider.of<TaskService>(context)
                              .getGroupedTasksByProject(tasks, project),
                          timeEntries: Provider.of<TimeService>(context)
                              .getGroupedTimeEntriesByProject(timeEntries, project)
                      )
                  )
              );
            }).toList());
  }
}
