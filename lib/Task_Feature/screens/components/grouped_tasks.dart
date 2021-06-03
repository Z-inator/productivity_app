import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';

import '../../../Task_Feature/Task_Feature.dart';

class GroupedTasks extends StatelessWidget {
  final List<Task>? tasks;
  const GroupedTasks({this.tasks});

  @override
  Widget build(BuildContext context) {
    return tasks == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : tasks!.isEmpty
            ? Center(
                child: Text(
                'No Tasks Yet',
                style: DynamicColorTheme.of(context).data.textTheme.caption,
              ))
            : ListBody(
                children: tasks!.map((task) {
                  return TaskExpansionTile(task: task);
                }).toList(),
              );
  }
}
