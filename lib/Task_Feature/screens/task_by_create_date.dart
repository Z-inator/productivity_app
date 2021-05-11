import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/grouped_tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class TaskByCreateDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TaskService taskService = Provider.of<TaskService>(context);
    final List<Task> tasks = Provider.of<List<Task>>(context);
    List<DateTime> days = taskService.getDays(tasks, false);
    return days == null
        ? Center(child: CircularProgressIndicator())
        : days.isEmpty
            ? Center(child: Text('There are no Tasks with a due date.'))
            : ListView(
                padding: EdgeInsets.only(bottom: 100),
                children: days.map((day) {
                  List<Task> associatedTasks =
                      taskService.getTasksByDate(tasks, day, false);
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(DateTimeFunctions()
                                .dateTimeToTextDate(date: day)),
                            trailing: Text(associatedTasks.length.toString(),
                                style: DynamicColorTheme.of(context)
                                    .data
                                    .textTheme
                                    .subtitle1),
                          ),
                          GroupedTasks(associatedTasks: associatedTasks)
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
  }
}
