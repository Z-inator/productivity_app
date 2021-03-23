import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/screens/tasks/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/times_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TasksByProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = Provider.of<List<Task>>(context);
    return ListBody(
      children: filterByProject(tasks, associatedProjectName).map((task) {
        return Theme(
          data: Theme.of(context)
              .copyWith(accentColor: Theme.of(context).unselectedWidgetColor),
          child: ExpansionTile(
            initiallyExpanded: false,
            leading: Icon(
              Icons.play_arrow_rounded,
              color: Colors.green,
            ),
            title: Text(
              task.taskName,
            ),
            trailing: IconButton(
                icon: Icon(Icons.edit_rounded),
                onPressed: () {
                  // showModalBottomSheet(
                  //     context: context,
                  //     isScrollControlled:
                  //         true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(20),
                  //             topRight: Radius.circular(20))),
                  //     builder: (BuildContext context) {
                  //       return ProjectEditBottomSheet(
                  //         projectName: projectName,
                  //         projectColor: projectColor,
                  //         projectClient: projectClient,
                  //         projectID: docID,
                  //       );
                  //     });
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
                    Text('Status: ${task.status}',
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
            ],
          ),
        );
      }).toList(),
    );
  }
}