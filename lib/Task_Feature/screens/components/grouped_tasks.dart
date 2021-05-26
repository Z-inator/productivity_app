import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class GroupedTasks extends StatelessWidget {
  final List<Task> tasks;
  const GroupedTasks({this.tasks});

  @override
  Widget build(BuildContext context) {
    return tasks == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : tasks.isEmpty
            ? Center(
                child: Text(
                'No Tasks Yet',
                style: DynamicColorTheme.of(context).data.textTheme.caption,
              ))
            : ListBody(
                children: tasks.map((task) {
                  return TaskExpansionTile(task: task);
                }).toList(),
              );
  }
}
