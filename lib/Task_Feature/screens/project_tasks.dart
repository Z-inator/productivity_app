import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatelessWidget {
  final Project project;
  ProjectPage({this.project});

  List<Task> filteredTasks(List<Task> tasks) {
    return tasks.where((task) => task.project == project).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(project.projectName),
              floating: true,
              expandedHeight: MediaQuery.of(context).size.height / 4,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: tasks == null
        ? CircularProgressIndicator()
        : ListView(
          padding: EdgeInsets.only(bottom: 100),
          children: filteredTasks(tasks).map((task) {
            return TaskExpansionTile(task: task);
          }).toList(),
        ),
      ),
      // TODO: begin work on this page
    );
  }
}


