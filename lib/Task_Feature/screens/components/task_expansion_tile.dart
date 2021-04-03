import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class TaskExpansionTile extends StatelessWidget {
  final Task task;
  const TaskExpansionTile({Key key, this.task}) : super(key: key);

  void showEditModalBottomSheet() {}

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      leading: IconButton(
        icon: Icon(Icons.play_arrow_rounded),
        color: Colors.green,
        onPressed: () {},
      ),
      title: Text(
        task.taskName,
      ),
      trailing: IconButton(
          icon: Icon(Icons.edit_rounded),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled:
                    true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                builder: (BuildContext context) {
                  return ChangeNotifierProvider(
                      create: (context) => TaskEditState(),
                      child: TaskEditBottomSheet(
                        task: task,
                        isUpdate: true,
                      ));
                });
          }),
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Due Date: ${DateTimeFunctions().dateToText(date: task.dueDate)}',
                  style: Theme.of(context).textTheme.subtitle1),
              Text('Project: ${task.project.projectName}',
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Time: ${TimeFunctions().timeToText(seconds: task.taskTime)}',
                  style: Theme.of(context).textTheme.subtitle1),
              OutlinedButton.icon(
                icon: Icon(Icons.playlist_add_check_rounded),
                label: Text('Subtasks:\n10'),
                onPressed: () {
                  // Navigator.pushNamed(context, '/taskscreen',
                  //     arguments: projectName);
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
              'Create Date: ${DateTimeFunctions().dateToText(date: task.createDate)}',
              style: Theme.of(context).textTheme.subtitle1),
        ),
      ],
    );
  }
}
