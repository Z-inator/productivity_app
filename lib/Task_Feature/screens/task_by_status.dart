import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state_provider.dart';
import 'package:productivity_app/Task_Feature/screens/components/grouped_tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Shared/datetime_functions.dart';
import 'package:productivity_app/Shared/time_functions.dart';

import 'package:provider/provider.dart';

class TasksByStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Status> statuses = Provider.of<List<Status>>(context);
    List<Task> tasks = Provider.of<List<Task>>(context);

    return statuses == null || tasks == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : TaskByStatusBody(statuses: statuses, tasks: tasks);
  }
}

class TaskByStatusBody extends StatelessWidget {
  const TaskByStatusBody({
    Key key,
    @required this.statuses,
    @required this.tasks,
  }) : super(key: key);

  final List<Status> statuses;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    print(tasks);
    statuses.sort((a, b) => a.statusOrder.compareTo(b.statusOrder));
    return ListView(
      padding: EdgeInsets.only(bottom: 100),
      children: statuses.map((status) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatusExpansionTile(status: status),
                Divider(),
                GroupedTasks(
                    associatedTasks:
                        tasks.where((task) => task.status == status).toList())
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
