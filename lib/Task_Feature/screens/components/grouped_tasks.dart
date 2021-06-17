import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';

import '../../../Task_Feature/Task_Feature.dart';

class GroupedTasks extends StatelessWidget {
  final List<Task> tasks;
  const GroupedTasks({required this.tasks});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = DynamicColorTheme.of(context).data;
    return tasks.isEmpty
            ? Center(
                child: Text(
                'No Tasks Yet',
                style: themeData.textTheme.caption,
              ))
            : ListBody(
                children: tasks.map((task) {
                  return TaskExpansionTile(task: task);
                }).toList(),
              );
  }
}
