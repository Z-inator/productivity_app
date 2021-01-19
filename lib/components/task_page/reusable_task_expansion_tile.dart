import 'package:flutter/material.dart';
import 'due_task_list_builder.dart';

class TaskExpansionTile extends StatelessWidget {
  String day;
  String taskCount;

  TaskExpansionTile({
    this.day,
    this.taskCount,

  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Tasks Due $day'),
      subtitle: Text(taskCount,
      ),
      children: [
        Container(
          height: 120,
          child: TasksDueToday(),
        )
      ]
    );
  }
}
