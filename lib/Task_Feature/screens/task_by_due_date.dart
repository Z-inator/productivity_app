import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class TaskByDueDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = Provider.of<List<Task>>(context);
    return tasks == null
    ? Center(child: CircularProgressIndicator())
    : TaskByDueDateBody(tasks: tasks);
    
  }
}

class TaskByDueDateBody extends StatelessWidget {
  const TaskByDueDateBody({
    Key key,
    @required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return ListView(
      children: tasks.map((task) {
        return Theme(
          data: Theme.of(context)
              .copyWith(accentColor: Theme.of(context).unselectedWidgetColor),
          child: TaskExpansionTile(task: task),
        );
      }).toList(),
    );
  }
}


