import 'package:cloud_firestore/cloud_firestore.dart';
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
  final List<Task> associatedTasks;
  const GroupedTasks({this.associatedTasks});

  @override
  Widget build(BuildContext context) {
    
    return associatedTasks == null 
    ? Center(child: CircularProgressIndicator(),)
    : associatedTasks.isEmpty
        ? Center(child: Text('No Tasks Yet', style: Theme.of(context).textTheme.caption,))
        : ListBody(
            children: associatedTasks.map((task) {
              return TaskExpansionTile(task: task);
            }).toList(),
          );
  }
}
