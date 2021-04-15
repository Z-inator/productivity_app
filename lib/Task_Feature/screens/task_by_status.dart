import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/grouped_tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';

import 'package:provider/provider.dart';

class TasksByStatus extends StatelessWidget {
  final List<Task> associatedTasks;
  const TasksByStatus({this.associatedTasks});

  @override
  Widget build(BuildContext context) {
    final List<Status> statuses = Provider.of<List<Status>>(context);
    final TaskService taskService = Provider.of<TaskService>(context);
    final List<Task> tasks = Provider.of<List<Task>>(context);
    return statuses == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : statuses.isEmpty
            ? Center(child: Text('Create Statuses to group Tasks'))
            : ListView(
                padding: EdgeInsets.only(bottom: 100),
                children: statuses.map((status) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          StatusExpansionTile(
                            status: status,
                          ),
                          GroupedTasks(
                              associatedTasks: taskService.getTasksByStatus(
                                      associatedTasks ?? tasks, status))
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
  }
}

// class TaskByStatusBody extends StatelessWidget {
//   const TaskByStatusBody({
//     Key key,
//     @required this.statuses,
//   }) : super(key: key);

//   final List<Status> statuses;

//   @override
//   Widget build(BuildContext context) {
//     final TaskService taskState = Provider.of<TaskService>(context);
//     return ListView(
//       padding: EdgeInsets.only(bottom: 100),
//       children: statuses.map((status) {
//         return Container(
//           padding: EdgeInsets.all(10),
//           child: Card(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 StatusExpansionTile(
//                     status: status,
//                 ),
//                 GroupedTasks(
//                     associatedTasks: associ
//                         taskState.getGroupedTasksByStatus(context, status))
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
