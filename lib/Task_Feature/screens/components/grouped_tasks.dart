import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';

class GroupedTasks extends StatelessWidget {
  final List<Task> tasks;
  const GroupedTasks({this.tasks});

  @override
  Widget build(BuildContext context) {
    return tasks == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : tasks.isEmpty
            ? Center(
                child: Text(
                'No Tasks Yet',
                style: DynamicTheme.of(context).theme.textTheme.caption,
              ))
            : ListBody(
                children: tasks.map((task) {
                  return TaskExpansionTile(task: task);
                }).toList(),
              );
  }
}
