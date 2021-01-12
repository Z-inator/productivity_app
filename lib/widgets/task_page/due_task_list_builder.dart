import 'package:flutter/material.dart';
import 'reusable_expanded_task_row.dart';

class TasksDueToday extends StatefulWidget {
  @override
  _TasksDueTodayState createState() => _TasksDueTodayState();
}

class _TasksDueTodayState extends State<TasksDueToday> {
  final List<String> dueTaskList = ['Due Task 1','Due Task 2', 'Due Task 3', 'Due Task 4', 'Due Task 5'];
  final List<String> statuses = ['ToDo', 'In Progress', 'Done'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dueTaskList.length,
      itemBuilder: (context, index) {
        return ExpandedTaskRow(statuses: statuses, dueTask: dueTaskList[index]);
      },
    );
  }
}


