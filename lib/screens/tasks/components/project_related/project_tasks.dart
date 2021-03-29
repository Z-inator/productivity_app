import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class AssociatedTasks extends StatelessWidget {
  final String projectName;
  AssociatedTasks({this.projectName});

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    List<Task> tasks = Provider.of<List<Task>>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Scrollbar(
        child: ListView(
            children: tasks.map((task) {
          final String taskID = task.taskID;
          final String taskName = task.taskName;
          final String projectName = task.project.projectName;
          final String status = task.status.statusName;
          final DateTime dueDate = task.dueDate;
          final String dueDateString =
              DateTimeFunctions().dateToText(date: dueDate).toString();
          final String elapsedTime =
              TimeFunctions().timeToText(seconds: task.taskTime);
          return Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              leading: IconButton(
                icon: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.green,
                ),
                onPressed: () {},
              ),
              title: Text(taskName),
              subtitle: Text(dueDateString),
              trailing: Text(elapsedTime),
              onTap: () {},
            ),
          );
        }).toList()),
      )),
    );
  }
}
