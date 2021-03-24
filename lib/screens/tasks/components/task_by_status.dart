import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/status.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/screens/tasks/components/status_edit_bottomsheet.dart';
import 'package:productivity_app/screens/tasks/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/services/statuses_data.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';

import 'package:provider/provider.dart';

class TasksByStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Status> statuses = Provider.of<List<Status>>(context);
    statuses.sort((a, b) => a.statusOrder.compareTo(b.statusOrder));
    return ListView(
      padding: EdgeInsets.only(bottom: 100),
      children: statuses.map((status) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    accentColor: Theme.of(context).unselectedWidgetColor,
                  ),
                  child: ExpansionTile(
                      initiallyExpanded: false,
                      leading: Icon(
                        Icons.circle,
                        color: Color(status.statusColor),
                      ),
                      title: Text(
                        status.statusName,
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                builder: (BuildContext context) {
                                  return StatusEditBottomSheet(status: status,);
                                });
                          }),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Text('Tasks: 10',
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Text(
                                'Description\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel.',
                                overflow: TextOverflow.fade,
                                maxLines: 3,
                                style: Theme.of(context).textTheme.subtitle1))
                      ]),
                ),
                Divider(),
                GroupByStatus(
                  associatedStatus: status.statusName,
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class GroupByStatus extends StatelessWidget {
  final String associatedStatus;
  GroupByStatus({this.associatedStatus});

  List<Task> filterByStatus(List<Task> tasks, String associatedStatus) {
    return tasks.where((task) => task.status == associatedStatus).toList();
  }

  // TODO: look at adding an init method to run the .where when the widget is created

  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = Provider.of<List<Task>>(context);
    return ListBody(
      children: filterByStatus(tasks, associatedStatus).map((task) {
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
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled:
                          true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (BuildContext context) {
                        return TaskEditBottomSheet(task: task);
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
                    Text('Project: ${task.projectName}',
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
          ),
        );
      }).toList(),
    );
  }
}
